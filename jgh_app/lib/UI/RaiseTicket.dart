import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:jgh_app/Api_Call/ticketList.dart';
import 'package:jgh_app/Model/Profile_Model.dart';
import 'package:jgh_app/Model/RaiseTicketModel.dart';
import 'package:jgh_app/UI/CreateTicket.dart';
import 'package:url_launcher/url_launcher.dart';



class RaiseTicket extends StatefulWidget{
  State<StatefulWidget> createState(){
    return RaiseTicketState();
  }
}

class RaiseTicketState extends State<RaiseTicket>{

  Widget build(BuildContext){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Color(0xffe6eeff),
            ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height*0.085,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xff273894),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      Text("Raise ticket", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: height*0.35,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Center(child: Image.asset("assets/Ellipse 1311.png")),
                            Center(child: Image.asset("assets/call-center-worker-with-headset-svgrepo-com 2.png")),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,height*0.245,0,0),
                      child: Center(
                        child: Column(
                          children: [
                            Text("Hello! How can we", style: TextStyle(fontSize: 24, color: Color(0xff273894),),),
                            Text("help you?", style: TextStyle(fontSize: 24, color: Color(0xff273894),),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: height*0.2,
                        width: width*0.3,
                        child: InkWell(
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.asset("assets/3d-fluency-whatsapp-logo 1.png"),
                                Text("Message on"),
                                Text("WhatsApp"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          onTap: () async{
                            final String phone = "91${RaiseTicketModel.whatsappNo}"; // phone number with country code
                            final String message = "Hello";
                            final url = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              throw "Could not launch $url";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height*0.2,
                        width: width*0.3,
                        child: InkWell(
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.asset("assets/gmail 1.png"),
                                Text("Send an email"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          onTap: () async{
                            final MailOptions mailOptions = MailOptions(
                            body: 'Hello Sir',
                            subject: 'the Email Subject',
                            recipients: ['${RaiseTicketModel.email}'],
                            isHTML: false,
                            bccRecipients: [''],
                            ccRecipients: [''],
                            attachments: [ '', ],
                            );

                            final MailerResponse response = await FlutterMailer.send(mailOptions);
                            switch (response) {
                            case MailerResponse.saved: /// ios only
                            var platformResponse = 'mail was saved to draft';
                            break;
                            case MailerResponse.sent: /// ios only
                            var platformResponse = 'mail was sent';
                            break;
                            case MailerResponse.cancelled: /// ios only
                            var platformResponse = 'mail was cancelled';
                            break;
                            case MailerResponse.android:
                            var platformResponse = 'intent was successful';
                            break;
                            default:
                            var platformResponse = 'unknown';
                            break;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height*0.2,
                        width: width*0.3,
                        child: InkWell(
                          child: Card(
                            color: Colors.white,
                            child:  Column(
                              children: [
                                Image.asset("assets/images 3.png"),
                                Text("Make a call"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          onTap: () async{
                            final Uri callUri = Uri.parse("tel:${RaiseTicketModel.mobileNo}");
                            if (await canLaunchUrl(callUri)) {
                            await launchUrl(callUri);
                            } else {
                            throw 'Could not launch dialer';
                            }
                          },
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height*0.06,
                            width: width*0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xffFBB82A), width: 2)
                            ),
                            child: Row(
                              children: [
                                Text("Raise ticket", style: TextStyle(fontSize: 16),),
                                Image.asset("assets/question-mark-bubble-speech-sign-symbol-icon-3d-rendering-b 1.png",scale: 0.9,),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          SizedBox(
                            height: height*0.06,
                            width: width*0.45,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTicket()));
                                  },
                                  child: Text(""),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent
                                ),
                              ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: height*0.06,
                            width: width*0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xffFBB82A), width: 2)
                            ),
                            child: Row(
                              children: [
                                Text("Ticket History", style: TextStyle(fontSize: 16),),
                                Image.asset("assets/material-symbols_history-rounded.png",scale: 0.9,),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          SizedBox(
                            height: height*0.06,
                            width: width*0.45,
                            child: ElevatedButton(
                              onPressed: () async{
                                await TicketList_ApiCall.ticketListApi(context, ProfileData.id!);
                              },
                              child: Text(""),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}













