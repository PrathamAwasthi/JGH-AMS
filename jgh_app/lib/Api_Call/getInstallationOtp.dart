import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/UI/RequestStatus.dart';
import 'package:jgh_app/Util/AppConst.dart';

List<String> imagesUrl = [];
class GetInstallationApi_ApiCall {
  static Future<int> getInstallationApi(BuildContext context, String requestId, String phone) async{
    try{
      var url = Uri.parse(AppConst.getInstallationOtpUrl);
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "mobile_no": phone,
        "request_id": requestId,
      });

      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"] == "success"){
          RequestStatusState.uploadImage = true;
          RequestStatusState.requestProvider!.updateState();
          Fluttertoast.showToast(
              msg: "The OTP was sent to the retailer",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pop(context);
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}







