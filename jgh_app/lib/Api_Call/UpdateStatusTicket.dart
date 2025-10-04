import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/SubmitFeedback.dart';
import 'package:jgh_app/Api_Call/getTicketDetailsApi.dart';
import 'package:jgh_app/Api_Call/ticketList.dart';
import 'package:jgh_app/Model/Profile_Model.dart';
import 'package:jgh_app/UI/Message.dart';


class UpdateStatusTicket_ApiCall {
  static Future<int> updateStatusTicket(BuildContext context, {required String ticketId, String? status}) async{
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController detailReview = TextEditingController();
    try{
      var url = Uri.parse("https://jghmagic.zolopay.in/api/update-status");
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "unique_key": "ABCDEFGH678540345D",
        "ticket_id": ticketId,
        "status": status,
        "check": "1",
        "category": "6",
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
          fontSize: 16.0,
        );
        Navigator.pop(context);
        return 1;
      }

      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["success"]){
          await GetTicketDetails_ApiCall.getTicketDetails(context, ticketId, check: false);
          await TicketList_ApiCall.ticketListApi(context, ProfileData.id!, check: false);
          MessageState.provider2!.updateState();
          if(status != "1"){
            Navigator.pop(context);
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              backgroundColor: Colors.white,
              builder: (BuildContext context) {
                return Container(
                  height: height*0.7,
                  width: width,
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Your ticket has been closed", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("Please share your feedback", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.68,height*0.005),
                          child: Text("Detail Review", style: TextStyle(color: Colors.grey),),
                        ),
                        TextField(
                          controller: detailReview,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: "Write something",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          maxLines: 5,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced, // Forcefully enforce limit
                          keyboardType: TextInputType.text,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                          child: SizedBox(
                            height: height*0.05,
                            width: width*0.95 ,
                            child: ElevatedButton(
                              onPressed: () async{
                                await SubmitFeedback_ApiCall.submitFeedback(context, ticketId: ticketId, user_id: ProfileData.id!, review_message: detailReview.text.toString());
                              },
                              child: Text("Send Review", style: TextStyle(color: Colors.black),),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color(0xffFEB617),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }

}











