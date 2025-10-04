import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/InstallationCompletedApi.dart';
import 'package:jgh_app/Api_Call/dashboardApi.dart';
import 'package:jgh_app/Api_Call/installationListApi.dart';
import 'package:jgh_app/Model/Dashboard_Model.dart';
import 'package:jgh_app/UI/Dashboard.dart';
import 'package:jgh_app/UI/Installation.dart';
import '../Model/Profile_Model.dart';


class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: RefreshIndicator(
          child: ListView(
            children: [
              Column(
                children: [
                  InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*0.02,height*0.02,0,0),
                      child: Container(
                          height: height*0.07,
                          width: height*0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle,
                            border: Border.all(color: Colors.indigo),
                          ),
                          child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,))),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*0.04,height*0.02,0,0),
                      child: Text("Hi ${ProfileData.name}", style: TextStyle(color: Colors.black, fontSize: 16),),
                    ),
                  ],
                ),
                onTap: (){
                  gloebleProvider!.profile();
                },
              ),
                  Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.015,0,0),
                child: Row(
                  children: [
                    SizedBox(
                      height: height*0.16,
                      width: width*0.48,
                      child: Card(
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xffFFECEB),
                              Colors.white,
                            ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              gloebleProvider!.survey();
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.2,height*0.02,0,0),
                                  child: Image.asset("assets/Frame 1984079735.png", scale: 0.8,),
                                ),
                                Container(
                                  height: height*0.04,
                                  width: width*0.3,
                                  color: Colors.transparent,
                                  child: Text("${DashboardModel.surveyPending}", style: TextStyle(fontSize: 24, color: Colors.pinkAccent), overflow: TextOverflow.ellipsis,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Survey Pending", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height*0.16,
                      width: width*0.48,
                      child: Card(
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xffEBFFFD),
                              Colors.white,
                            ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () async{
                              status = "2";
                              await InstallationListApi_ApiCall.installationListApi(context, "2");
                              setState(() {});
                              gloebleProvider!.installation();
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.2,height*0.02,0,0),
                                  child: Image.asset("assets/Frame 1984079735 (1).png", scale: 0.8,),
                                ),
                                Container(
                                  height: height*0.04,
                                  width: width*0.3,
                                  color: Colors.transparent,
                                  child: Text("${DashboardModel.approvalPending}", style: TextStyle(fontSize: 24, color: Colors.pinkAccent), overflow: TextOverflow.ellipsis,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Approval Pending", style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                    child: Row(
                      children: [
                        SizedBox(
                      height: height*0.16,
                      width: width*0.48,
                      child: Card(
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xffFFFDEB),
                              Colors.white,
                            ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () async{
                              status = "3";
                              await InstallationListApi_ApiCall.installationListApi(context, "3");
                              setState(() {});
                              gloebleProvider!.installation();
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.2,height*0.02,0,0),
                                  child: Image.asset("assets/Frame 1984079735 (2).png", scale: 0.8,),
                                ),
                                Container(
                                  height: height*0.04,
                                  width: width*0.3,
                                  color: Colors.transparent,
                                  child: Text("${DashboardModel.installationPending}", style: TextStyle(fontSize: 24, color: Colors.pinkAccent), overflow: TextOverflow.ellipsis,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Installation Pending", style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent
                            ),
                          ),
                        ),
                      ),
                    ),
                        SizedBox(
                      height: height*0.16,
                      width: width*0.48,
                      child: Card(
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color(0xffF0EEFF),
                              Colors.white,
                            ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () async{
                              await InstallationCompletedApi_ApiCall.installationCompletedApiApi(context,"1");
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.2,height*0.02,0,0),
                                  child: Image.asset("assets/Frame 1984079735 (3).png", scale: 0.8,),
                                ),
                                Container(
                                  height: height*0.04,
                                  width: width*0.3,
                                  color: Colors.transparent,
                                  child: Text("${DashboardModel.installationCompleted}", style: TextStyle(fontSize: 24, color: Colors.pinkAccent), overflow: TextOverflow.ellipsis,),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Installation Completed", style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onRefresh: () async{
            await DashboardApi_ApiCall.dashboardApi(context);
            setState(() {});
          },
      ),
    );
  }
}





