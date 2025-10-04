import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'getTicketDetailsApi.dart';


class AddReplyTicket_ApiCall {
  static Future<int> addReplyTicket(BuildContext context, {required String ticketId, String? comment, List<File>? images}) async{
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/add-reply");
      var headers = {
        'Content-Type': 'application/json',
      };
      var body;
      if(comment != null && images == null){
        body = jsonEncode({
          "unique_key": "ABCDEFGH678540345D",
          "ticket_id": ticketId,
          "comment": comment,
          "check": "1",
          "category": "6",
        });
      }else if(images != null && comment == null){
        List<String> images64Byte = [];
        for(int i=0;i<images.length;i++){
          final bytes = await images[i].readAsBytes();
          final base64Image = base64Encode(bytes);
          images64Byte.add("data:image/png;base64,$base64Image");
        }
        body = jsonEncode({
          "unique_key": "ABCDEFGH678540345D",
          "ticket_id": ticketId,
          "media": images64Byte,
          "comment": "null",
          "check": "1",
          "category": "6",
        });
      }else if(images != null && comment != null){
        List<String> images64Byte = [];
        for(int i=0;i<images.length;i++){
          final bytes = await images[i].readAsBytes();
          final base64Image = base64Encode(bytes);
          images64Byte.add("data:image/png;base64,$base64Image");
        }
        body = jsonEncode({
          "unique_key": "ABCDEFGH678540345D",
          "ticket_id": ticketId,
          "comment": comment,
          "media": images64Byte,
          "check": "1",
          "category": "6",
        });
      }
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
            fontSize: 16.0,
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
          await GetTicketDetails_ApiCall.getTicketDetails(context, ticketId, check: false);
          }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}


