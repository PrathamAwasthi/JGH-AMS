import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/PaymentListModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

class PaymentListApi_ApiCall {
  static Future<int> paymentListApi(BuildContext context) async{
    try{
      var url = Uri.parse(AppConst.paymentStatusUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
      });
      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          paymentListModelObjects = [];
          for(int i=0;i<data["payment_list"]["data"].length;i++){
            PaymentListModel ob = PaymentListModel(
                userId: data["payment_list"]["data"][i]["user_id"].toString(),
                latestUpdatedAt: data["payment_list"]["data"][i]["latest_updated_at"].toString(),
                createdAt: data["payment_list"]["data"][i]["created_at"].toString(),
                ownerName: data["payment_list"]["data"][i]["owner_name"].toString(),
                countryCode: data["payment_list"]["data"][i]["country_code"].toString(),
                mobileNumber: data["payment_list"]["data"][i]["mobile_number"].toString(),
                shopName: data["payment_list"]["data"][i]["shop_name"].toString(),
                locationImage: data["payment_list"]["data"][i]["location_image"].toString(),
                city: data["payment_list"]["data"][i]["city"].toString(),
                stateName: data["payment_list"]["data"][i]["state_name"].toString(),
                address: data["payment_list"]["data"][i]["address"].toString(),
                pincode: data["payment_list"]["data"][i]["pincode"].toString(),
                brandingElements: data["payment_list"]["data"][i]["branding_elements"].toString(),
            );
            paymentListModelObjects.add(ob);
          }
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }

}









