import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/RaiseTicketModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

class RaiseTicket_ApiCall {
  static Future<int> RaiseTicketProfile(BuildContext context) async{
    try{
      var url = Uri.parse(AppConst.raiseTicketUrl);
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
        if(data["status"] == "success"){
          RaiseTicketModel.email = data["raise_ticket"]["email"].toString();
          RaiseTicketModel.mobileNo = data["raise_ticket"]["mobile"].toString();
          RaiseTicketModel.whatsappNo = data["raise_ticket"]["whatsapp_number"].toString();
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}