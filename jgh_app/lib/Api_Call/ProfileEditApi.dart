import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/profileApi.dart';
import 'package:jgh_app/Util/AppConst.dart';

class EditProfile_ApiCall {
  static Future<int> editProfile(BuildContext context, {required String name, required String phone, required String email, required String panCard, required String gst_number, required String shop_name, required String address, required String shop_image, required String profile_image, required String adhar_number}) async{
    try{
      var url = Uri.parse(AppConst.editProfileUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "name": name,
        "phone": phone,
        "email": email,
        "pancard": panCard,
        "gst_number": gst_number,
        "shop_name": shop_name,
        "address": address,
        "shop_image": shop_image,
        "profile_image": profile_image,
        "adhar_number": adhar_number,
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
      final data = jsonDecode(response.body);
      if(response.statusCode == 200){
        print(data);
        if(data["status"]){
          Fluttertoast.showToast(
              msg: "Profile updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
          await Profile_ApiCall.profileOtp(context);
        }
      } else{
        print(data);
        List<String> keyList = [];
        for(var i in data["errors"].keys){
          keyList.add(i.toString());
        }
        if(keyList.contains("gst_number")){
          Fluttertoast.showToast(
              msg: "Invalid GST Number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        if(keyList.contains("adhar_number")) {
          Fluttertoast.showToast(
              msg: "Invalid Aadhaar Number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
          if(keyList.contains("pancard")) {
            Fluttertoast.showToast(
                msg: "Invalid Pan Card Number",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
      }
    } catch(e){
      return 1;
    }
    return 0;
  }
}


