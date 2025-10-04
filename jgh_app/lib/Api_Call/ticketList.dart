import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/TicketList_Model.dart';
import '../UI/TicketHistory.dart';

class TicketList_ApiCall {
  static Future<int> ticketListApi(BuildContext context, String id, {bool check = true}) async{
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/my-tickets");
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        "unique_key": "ABCDEFGH678540345D",
        "user_id": id,
        "category": "6",
        "check": "1"
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
      var response = await http.post(url, headers: headers, body: body);
      Navigator.pop(context);
      print(response.statusCode);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["success"]){
          ticketListModelObject = [];
          for(int i=0;i<data["data"].length;i++){
            TicketListModel ob = TicketListModel(
              id: data["data"][i]["id"].toString(),
              userId: data["data"][i]["user_id"].toString(),
              title: data["data"][i]["title"].toString(),
              description: data["data"][i]["description"].toString(),
              status: data["data"][i]["status"].toString(),
              priority: data["data"][i]["priority"].toString(),
              assignedTo: data["data"][i]["assigned_to"].toString(),
              createdAt: data["data"][i]["created_at"].toString(),
              updatedAt: data["data"][i]["updated_at"].toString(),
              category: data["data"][i]["category"].toString(),
              generationSource: data["data"][i]["generation_source"].toString(),
              belongsTo: data["data"][i]["belongs_to"].toString(),
              mediaFiles: data["data"][i]["media_files"],
            );
            ticketListModelObject.add(ob);
          }
          if(check){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketHistory()));
          }else{
            print("rrrrrrrrrrrrrrrrrrrrrrRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            print("rrrrrrrrrrrrrrrrrrrrrrRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            print("rrrrrrrrrrrrrrrrrrrrrrRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            print("rrrrrrrrrrrrrrrrrrrrrrRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            ticketHistoryState!.updateState();
          }
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}



