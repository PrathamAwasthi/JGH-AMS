import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Database/OpenDatabase.dart';
import 'package:jgh_app/Util/AppConst.dart';

import '../UI/Dashboard.dart';

class PostOtp_ApiCall {
  static Future<int> postOtp(BuildContext context, String phoneNo, String otp) async{
    try{
      var url = Uri.parse(AppConst.login_with_otpUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "mobile_no": phoneNo,
        "otp": otp,
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
          AppConst.authCode = data["user_data"]["auth_code"].toString();
          await DatabaseOpen.openDB(context);
          await DatabaseOpen.insertDate(context, AppConst.connectionId, AppConst.authCode);
          Navigator.popUntil(context, (root) => root.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
        }else{
          Fluttertoast.showToast(
              msg: "Incorrect OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}