import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Util/AppConst.dart';
import '../UI/Dashboard.dart';

class UploadInstallationApi_ApiCall {
  static Future<int> uploadInstallationApi(BuildContext context, String requestId, String otp, String images) async{
    try{
      var url = Uri.parse(AppConst.uploadInstallationOtpUrl);
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "request_id": requestId,
        "otp": otp,
        "images": images,
      });

      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Installation was completed successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.popUntil(context, (root) => root.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
          return 0;
        } else{
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Incorrect OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return 1;
        }
      }else{
        return 1;
      }
    }catch(e){
      return 1;
    }
  }
}







