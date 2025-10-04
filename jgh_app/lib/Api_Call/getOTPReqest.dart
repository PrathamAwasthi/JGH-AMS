import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Util/AppConst.dart';

class GetOtp_ApiCall {
  static Future<int> getOtp(BuildContext context, String phoneNo) async{
    try{
      var url = Uri.parse(AppConst.request_login_otpUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "mobile_no": phoneNo,
      });
      var response = await http.post(url,headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        if(data["status"]=="success"){
          print("OTP Send Successfully");
          return 0;
        }else{
          Fluttertoast.showToast(
              msg: "Invalid Phone Number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return 1;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}