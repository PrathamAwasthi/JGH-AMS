import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/Profile_Model.dart';
import 'package:jgh_app/Util/AppConst.dart';

class Profile_ApiCall {
  static Future<int> profileOtp(BuildContext context) async{
    try{
      var url = Uri.parse(AppConst.profileUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
      });
      var response = await http.post(url,headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        print(AppConst.authCode);
        print(AppConst.connectionId);
        if(data["status"]=="success"){
          ProfileData.id = data["vendor_profile"]["id"].toString();
          ProfileData.name = data["vendor_profile"]["name"].toString();
          ProfileData.email = data["vendor_profile"]["email"].toString();
          ProfileData.phone = data["vendor_profile"]["phone"].toString();
          ProfileData.gender = data["vendor_profile"]["gender"].toString();
          ProfileData.status = data["vendor_profile"]["status"].toString();
          ProfileData.stateId = data["vendor_profile"]["state_id"].toString();
          ProfileData.cityName = data["vendor_profile"]["city_name"].toString();
          ProfileData.address = data["vendor_profile"]["address"].toString();
          ProfileData.pincode = data["vendor_profile"]["pincode"].toString();
          ProfileData.shopName = data["vendor_profile"]["shop_name"].toString();
          ProfileData.shopImage = data["vendor_profile"]["shop_image"].toString();
          ProfileData.profileImage = data["vendor_profile"]["profile_image"].toString();
          ProfileData.lastLoginAt = data["vendor_profile"]["last_login_at"].toString();
          ProfileData.createdAt = data["vendor_profile"]["created_at"].toString();
          ProfileData.updatedAt = data["vendor_profile"]["updated_at"].toString();
          ProfileData.stateName = data["vendor_profile"]["state"]["sname"].toString();
          ProfileData.pancard = data["vendor_profile"]["pancard"].toString();
          ProfileData.adharNumber = data["vendor_profile"]["adhar_number"].toString();
          ProfileData.gstNumber = data["vendor_profile"]["gst_number"].toString();
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}