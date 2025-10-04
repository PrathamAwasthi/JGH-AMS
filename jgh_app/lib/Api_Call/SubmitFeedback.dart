import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../UI/Message.dart';

class SubmitFeedback_ApiCall {
  static Future<int> submitFeedback(BuildContext context, { required String ticketId, required String user_id, required String review_message}) async{
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/submit-feedback");
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "unique_key": "ABCDEFGH678540345D",
        "ticket_id": ticketId,
        "user_id": user_id,
        "review_message": review_message,
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
          fontSize: 16.0,
        );
        Navigator.pop(context);
        return 1;
      }
      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["message"] == "Feedback submitted successfully!"){
          Navigator.pop(context);
          MessageState.provider2!.updateState();
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}


