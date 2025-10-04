import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jgh_app/Api_Call/UpdateStatusTicket.dart';
import 'package:jgh_app/Api_Call/addReplyTicket.dart';
import 'package:jgh_app/Model/GetTicketDetailsModel.dart';
import 'package:jgh_app/ScreenState/InstallationStatusPageState.dart';
import 'package:jgh_app/UI/ViewImage.dart';
import 'package:provider/provider.dart';

import '../Api_Call/ticketList.dart';
import '../Model/Profile_Model.dart';


class Message extends StatefulWidget{
  State<StatefulWidget> createState(){
    return MessageState();
  }
}

class MessageState extends State<Message>{

  static InstallationStatusPageState? provider2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  TextEditingController message = TextEditingController();
  List<File> images = [];
  final ScrollController _scrollController = ScrollController();


  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height*0.085,
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
                  Text("${TicketDetailsModel.title}", style: TextStyle( color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: height*0.75,
                  width: width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: TicketDetailsModel.replies!.isNotEmpty ? TicketDetailsModel.replies!.length+1 : 2,
                    itemBuilder: (context, int index){
                      int n = TicketDetailsModel.replies!.isNotEmpty ? TicketDetailsModel.replies!.length : 1;
                      if(index == 0){
                        return TicketDetailsModel.replies!.isEmpty ? Container(
                          width: width,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.17,height*0.01,0,height*0.01),
                                    child: Container(
                                        height: height*0.025,
                                        width: width*0.55,
                                        color: Colors.transparent,
                                        child: Text(TicketDetailsModel.title!, style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,height*0.01,0,height*0.01),
                                    child: Container(
                                      height: height*0.025,
                                      width: width*0.22,
                                      color: Colors.transparent,
                                      child: Text(TicketDetailsModel.createdAt!, style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                    child: Container(
                                      child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,)),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width*0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: width*0.7,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(" "+TicketDetailsModel.description!, style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                                            ),
                                            Container(
                                              width: width*0.4,
                                              color: Colors.transparent,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: TicketDetailsModel.media!.length,
                                                itemBuilder: (context, int index){
                                                  if(TicketDetailsModel.media![index]["ticket_reply_id"] == null){
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                        child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.media![index]["file"]}",),
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.media![index]["file"]}")));
                                                        },
                                                      ),
                                                    );
                                                  }else{
                                                    return Container(height: null, width: null,);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),
                        ) :
                        Column(
                          children: [
                            Container(
                              width: width,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.17,height*0.01,0,height*0.01),
                                        child: Container(
                                            height: height*0.025,
                                            width: width*0.55,
                                            color: Colors.transparent,
                                            child: Text(TicketDetailsModel.title!, style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,height*0.01,0,height*0.01),
                                        child: Container(
                                          height: height*0.025,
                                          width: width*0.22,
                                          color: Colors.transparent,
                                          child: Text(TicketDetailsModel.createdAt!, style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                        child: Container(
                                          child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,)),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width*0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: width*0.7,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(" "+TicketDetailsModel.description!, style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                                                ),
                                                Container(
                                                  width: width*0.4,
                                                  color: Colors.transparent,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: TicketDetailsModel.media!.length,
                                                    itemBuilder: (context, int index){
                                                      if(TicketDetailsModel.media![index]["ticket_reply_id"] == null){
                                                        return Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: InkWell(
                                                            child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.media![index]["file"]}",),
                                                            onTap: (){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.media![index]["file"]}")));
                                                            },
                                                          ),
                                                        );
                                                      }else{
                                                        return Container(height: null, width: null,);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            ),
                            TicketDetailsModel.replies![index]["reply_by"] == "Assigned" ? Container(
                              width: width,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.1,height*0.05,0,0),
                                        child: Container(
                                          height: height*0.025,
                                          width: width*0.22,
                                          color: Colors.transparent,
                                          child: Text(TicketDetailsModel.createdAt!, style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width*0.8,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF2F8FF),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: width*0.7,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(" "+TicketDetailsModel.replies![index]["comment"]!, style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff273894)), overflow: TextOverflow.clip,),
                                                ),
                                                Container(
                                                  width: width*0.4,
                                                  color: Colors.transparent,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: TicketDetailsModel.replies![index]["media"].length,
                                                    itemBuilder: (context,int i){
                                                      return Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: InkWell(
                                                          child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][i]["file"]}",),
                                                          onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][i]["file"]}")));
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                        child: ClipOval(child: Image.asset("assets/Message Options.png", scale: 0.8,),),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            ) : Container(
                              width: width,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.06,height*0.01),
                                        child: Container(
                                          height: height*0.025,
                                          width: width*0.22,
                                          color: Colors.transparent,
                                          child: Text(TicketDetailsModel.replies![index]["created_at"], style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                        child: Container(
                                          child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,)),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width*0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: width*0.7,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(" "+TicketDetailsModel.replies![index]["comment"], style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                                                ),
                                                Container(
                                                  width: width*0.4,
                                                  color: Colors.transparent,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: TicketDetailsModel.replies![index]["media"].length,
                                                    itemBuilder: (context, int index){
                                                      return Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: InkWell(
                                                          child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][index]["file"]}",),
                                                          onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][index]["file"]}")));
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }else if(index == n){
                        return ChangeNotifierProvider<InstallationStatusPageState>(
                          create: (context) => InstallationStatusPageState(),
                          child: Consumer<InstallationStatusPageState>(builder: (context, provider, snapshot){
                            provider2 = provider;
                            return TicketDetailsModel.status != "3" ? Container(
                              width: width,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.1,height*0.05,0,0),
                                        child: Container(
                                          height: height*0.025,
                                          width: width*0.22,
                                          color: Colors.transparent,
                                          child: Text("", style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: height*0.12,
                                        width: width*0.8,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF2F8FF),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Has your issue been resolved?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                Spacer(flex: 10),
                                                ElevatedButton(
                                                  onPressed: () async{
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                                      ),
                                                      backgroundColor: Colors.white,
                                                      builder: (BuildContext context) {
                                                        return Container(
                                                          height: height*0.4,
                                                          width: width,
                                                          padding: EdgeInsets.all(16),
                                                          child: Column(
                                                            children: [
                                                              Spacer(flex: 5,),
                                                              Text("Are you sure you want to close", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                                              Text("your ticket?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                                              Text("You won't be able to make changes once it's closed", style: TextStyle(fontSize: 14,),),
                                                              Spacer(flex: 1,),
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                    height: height*0.05,
                                                                    width: width*0.35 ,
                                                                    child: ElevatedButton(
                                                                      onPressed: (){
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Text("Cancel", style: TextStyle(color: Colors.black),),
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            side: BorderSide(color: Colors.black),
                                                                          ),
                                                                          backgroundColor: Colors.white
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: height*0.05,
                                                                    width: width*0.35 ,
                                                                    child: ElevatedButton(
                                                                      onPressed: () async{
                                                                        await UpdateStatusTicket_ApiCall.updateStatusTicket(context, ticketId: TicketDetailsModel.id!, status: "3");
                                                                        setState(() {});
                                                                      },
                                                                      child: Text("Confirm", style: TextStyle(color: Colors.black),),
                                                                      style: ElevatedButton.styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                        ),
                                                                        backgroundColor: Color(0xffFEB617),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              ),
                                                              Spacer(flex: 10,),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    setState(() {});
                                                  },
                                                  child: Text("Yes"),
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      side: BorderSide(color: Colors.grey.shade300, width: 2,),
                                                    ),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                                Spacer(flex: 2,),
                                                ElevatedButton(
                                                  onPressed: () async{
                                                    await UpdateStatusTicket_ApiCall.updateStatusTicket(context, ticketId: TicketDetailsModel.id!, status: "1");
                                                  },
                                                  child: Text("No "),
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      side: BorderSide(color: Colors.grey.shade300, width: 2),
                                                    ),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                                Spacer(flex: 10,),
                                              ],
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            ):
                            Container(
                              width: width,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.1,height*0.05,0,0),
                                        child: Container(
                                          height: height*0.025,
                                          width: width*0.22,
                                          color: Colors.transparent,
                                          child: Text("", style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: height*0.12,
                                        width: width*0.8,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF2F8FF),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            bottomLeft: Radius.circular(40),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text("Has your issue been resolved?", style: TextStyle(fontSize: 16,),),
                                            Row(
                                              children: [
                                                Text("Ticket Resolved", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                                Icon(Icons.check_circle, color: Colors.green,),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      } else{
                        return TicketDetailsModel.replies![index]["reply_by"] == "Assigned" ? Container(
                          width: width,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.1,height*0.05,0,0),
                                    child: Container(
                                      height: height*0.025,
                                      width: width*0.22,
                                      color: Colors.transparent,
                                      child: Text(TicketDetailsModel.createdAt!, style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: width*0.8,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF2F8FF),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: width*0.7,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(" "+TicketDetailsModel.replies![index]["comment"]!, style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff273894)), overflow: TextOverflow.clip,),
                                            ),
                                            Container(
                                              width: width*0.4,
                                              color: Colors.transparent,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: TicketDetailsModel.replies![index]["media"].length,
                                                itemBuilder: (context,int i){
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                      child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][i]["file"]}",),
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][i]["file"]}")));
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                    child: ClipOval(child: Image.asset("assets/Message Options.png", scale: 0.8,),),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),
                        ) :
                        Container(
                          width: width,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.06,height*0.01),
                                    child: Container(
                                      height: height*0.025,
                                      width: width*0.22,
                                      color: Colors.transparent,
                                      child: Text(TicketDetailsModel.replies![index]["created_at"], style: TextStyle( fontSize: width*0.037, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                    child: Container(
                                      child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,)),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width*0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                        bottomLeft: Radius.circular(40),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: width*0.7,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(" " + (TicketDetailsModel.replies![index]["comment"] != "null" ? TicketDetailsModel.replies![index]["comment"]: ""), style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                                            ),
                                            Container(
                                              width: width*0.4,
                                              color: Colors.transparent,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: TicketDetailsModel.replies![index]["media"].length,
                                                itemBuilder: (context, int ita){
                                                  print("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][ita]["file"]}");
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                      child: Image.network("https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][ita]["file"]}",),
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "https://jghmagic.zolopay.in/uploads/ticket_media/${TicketDetailsModel.replies![index]["media"][ita]["file"]}")));
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                images.isNotEmpty ? Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.42,0,0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(onPressed: () {
                            images = [];
                            setState(() {});
                          }, icon: Icon(Icons.cancel_rounded, size: 38, color: Colors.black,),)),
                      Container(
                        height: height*0.2,
                        width: width,
                        color: Colors.grey.shade500,
                        child: ListView.builder(
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(images[index],),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ) : Text(""),
              ],
            ),
            Container(
              width: width,
              color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width*0.7,
                          child: TextField(
                            controller: message,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width),
                              ),
                              hintText: "Type a message...",
                              suffixIcon: IconButton(onPressed: () async{
                                final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(image != null){
                                  images.add(File(image.path));
                                }
                                setState(() {});
                              }, icon: Icon(Icons.attach_file)),
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          String ms = message.text.trim().toString();
                          print(ms);
                          if(images.isNotEmpty && ms == ""){
                            print(TicketDetailsModel.id!);
                            await AddReplyTicket_ApiCall.addReplyTicket(context, ticketId: TicketDetailsModel.id!, images: images);
                            images = [];
                            message.clear();
                            setState(() {});
                          }else if(images.isEmpty && ms != ""){
                            await AddReplyTicket_ApiCall.addReplyTicket(context, ticketId: TicketDetailsModel.id!, comment: ms);
                            images = [];
                            message.clear();
                            setState(() {});
                          }else if(images.isNotEmpty && ms != ""){
                            await AddReplyTicket_ApiCall.addReplyTicket(context, ticketId: TicketDetailsModel.id!, images: images, comment: ms);
                            images = [];
                            message.clear();
                            setState(() {});
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                            );
                          });
                          setState(() {});
                        },
                        child: Image.asset("assets/Send 2.png"),
                        shape: CircleBorder(),
                        backgroundColor: Color(0xffFBB82A),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    ));
  }
}
















