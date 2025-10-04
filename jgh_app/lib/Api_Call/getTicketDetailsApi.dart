import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/GetTicketDetailsModel.dart';
import '../UI/Message.dart';

class GetTicketDetails_ApiCall {
  static Future<int> getTicketDetails(BuildContext context, String ticketId,{bool check = true, bool ticketHistoryCheck = false}) async{
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/get-ticket-details");
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "unique_key": "ABCDEFGH678540345D",
        "ticket_id": ticketId,
        "check": "1",
        "category": "6",
      });
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            color: Colors.transparent,
            child: Center(child: CircularProgressIndicator(color: Colors.white,),),
          ),
        );
      });
      final bool isConnected = await InternetConnection().hasInternetAccess;
      if(!isConnected){
        Fluttertoast.showToast(
            msg: "Please Check Internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);
        return 1;
      }
      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        if(data["success"]){
          print(data);
          TicketDetailsModel.id = data["data"]["id"].toString();
          TicketDetailsModel.userId = data["data"]["user_id"].toString();
          TicketDetailsModel.title = data["data"]["title"].toString();
          TicketDetailsModel.description = data["data"]["description"].toString();
          TicketDetailsModel.status = data["data"]["status"].toString();
          TicketDetailsModel.priority = data["data"]["priority"].toString();
          TicketDetailsModel.createdAt = data["data"]["created_at"].toString();
          TicketDetailsModel.updatedAt = data["data"]["updated_at"].toString();
          TicketDetailsModel.generationSource = data["data"]["generation_source"].toString();
          TicketDetailsModel.belongsTo = data["data"]["belongs_to"].toString();
          TicketDetailsModel.replies = data["data"]["replies"];
          TicketDetailsModel.media = data["data"]["media"];
          if(check){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Message()));
          }else if(ticketHistoryCheck){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Message()));
          }
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}


