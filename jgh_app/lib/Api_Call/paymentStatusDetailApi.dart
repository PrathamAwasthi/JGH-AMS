import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/PaymentStatusDetailsModel.dart';
import 'package:jgh_app/UI/Pament%20Status.dart';
import 'package:jgh_app/Util/AppConst.dart';

class PaymentStatusDetailApi_ApiCall {
  static Future<int> paymentStatusDetailApi(BuildContext context, String ownerId, {String? status, String? startDate, String? endDate, String? navigate}) async{
    try{
      var url = Uri.parse(AppConst.paymentStatusDetailUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body;
      if(status!=null){
        body = jsonEncode({
          "connection_id": AppConst.connectionId,
          "auth_code": AppConst.authCode,
          "owner_id": ownerId,
          "payment_status": status,
        });
      }else if(startDate != null){
        body = jsonEncode({
          "connection_id": AppConst.connectionId,
          "auth_code": AppConst.authCode,
          "owner_id": ownerId,
          "start_date": startDate,
          "end_date": endDate,
        });
      }else{
        body = jsonEncode({
          "connection_id": AppConst.connectionId,
          "auth_code": AppConst.authCode,
          "owner_id": ownerId,
        });
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
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          paymentStatusDetailsModelObject = [];
          for(int i=0;i<data["payment_status_detail"].length;i++){
            PaymentStatusDetailsModel ob = PaymentStatusDetailsModel(
                id: data["payment_status_detail"][i]["id"].toString(),
                status: data["payment_status_detail"][i]["status"].toString(),
                paymentStatus: data["payment_status_detail"][i]["payment_status"].toString(),
                paymentDate: data["payment_status_detail"][i]["payment_date"].toString(),
                createdAt: data["payment_status_detail"][i]["created_at"].toString(),
                updatedAt: data["payment_status_detail"][i]["updated_at"].toString(),
                brandingElementName: data["payment_status_detail"][i]["branding_element_name"].toString(),
                dimensions: data["payment_status_detail"][i]["dimensions"],
                surveyImages: data["payment_status_detail"][i]["survey_images"],
                installationImages: data["payment_status_detail"][i]["installation_images"],
                installationDate: data["payment_status_detail"][i]["installation_date"].toString(),
                ownerName: data["payment_status_detail"][i]["owner_name"].toString(),
                countryCode: data["payment_status_detail"][i]["country_code"].toString(),
                mobileNumber: data["payment_status_detail"][i]["mobile_number"].toString(),
                shopName: data["payment_status_detail"][i]["shop_name"].toString(),
                city: data["payment_status_detail"][i]["city"].toString(),
                locationImage: data["payment_status_detail"][i]["location_image"].toString(),
                cost: data["payment_status_detail"][i]["cost"].toString(),
                paymentStatusLabel: data["payment_status_detail"][i]["payment_status_label"].toString(),
            );
            paymentStatusDetailsModelObject.add(ob);
          }
          if(navigate==null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentStatus(ownerId)));
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









