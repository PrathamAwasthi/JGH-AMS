import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/getTicketDetailsApi.dart';


class TicketStore_ApiCall {
  static Future<int> TicketStoreApi(BuildContext context, { required String userID, required String title, required String description, required List<File> images, required String? priority}) async{
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/ticket-store");
      var headers = {
        'Content-Type': 'application/json',
      };
      List<String> images64Byte = [];
      for(int i=0;i<images.length;i++){
        final bytes = await images[i].readAsBytes();
        final base64Image = base64Encode(bytes);
        images64Byte.add("data:image/png;base64,$base64Image");
      }
      var body = jsonEncode({
        "unique_key": "ABCDEFGH678540345D",
        "title": title,
        "description": description,
        "priority": priority,
        "user_id": userID,
        "media_files": images64Byte,
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
      var response = await http.post(url, headers: headers, body: body);
      Navigator.pop(context);
      print(response.statusCode);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]){
          print(data["data"]["id"]);
          await GetTicketDetails_ApiCall.getTicketDetails(context, data["data"]["id"].toString());
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}






