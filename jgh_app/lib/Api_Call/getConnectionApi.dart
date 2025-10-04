import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Util/AppConst.dart';
import '../UI/OTPPage.dart';
import 'getOTPReqest.dart';

class GetConnectionId_ApiCall {
  static Future<int> getConnectionId(BuildContext context, String phoneNo) async{
    try{
      var url = Uri.parse(AppConst.getConnectionUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "api_key": AppConst.apiKey,
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
        return 1;
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
      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        if(data["status"]=="success"){
          AppConst.connectionId = data["Data"].toString();
          int n = await GetOtp_ApiCall.getOtp(context, phoneNo);
          if(n==0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => OTPPage(phoneNo)));
          }
        }else{

        }
      }
    }catch(e){
      return 1;
    }

    return 0;
  }

}