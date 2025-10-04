import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/InstallationDetailApi.dart';
import 'package:jgh_app/Api_Call/installationListApi.dart';
import 'package:jgh_app/Model/InstallationListModel.dart';
import 'package:jgh_app/UI/RequestStatus.dart';

class InstallationPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return InstallationPageState();
  }
}

String status = "1";

class InstallationPageState extends State<InstallationPage>{
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: height*0.07,
            width: width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text((status == "1" ? "All: " : status == "2" ? "Pending: " : "Approved: ") +"${installationListModelObject.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Spacer(),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    icon: Icon(Icons.filter_alt_outlined),
                    onSelected: (value) async{
                      status = value;
                      await InstallationListApi_ApiCall.installationListApi(context, status);
                      setState(() {});
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: '1',
                        child: Text('All'),
                      ),
                      const PopupMenuItem(
                        value: '2',
                        child: Text('Pending'),
                      ),
                      const PopupMenuItem(
                        value: '3',
                        child: Text('Approved'),
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
            //height: height*0.6,
            width: width,
            color: Colors.transparent,
            child: RefreshIndicator(child: ListView.builder(
              itemCount: installationListModelObject.length,
              itemBuilder: (context, int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: height*0.4,
                    width: width,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  height: height*0.02,
                                  decoration: BoxDecoration(
                                    color: Color(0xffEBEEFF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Text("Req#0${installationListModelObject[index].id}", style: TextStyle(color: Color(0xff273894)),)),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.circle,size: 10, color: installationListModelObject[index].status == "2" ? Color(0xffFEB211) : Colors.green,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0,0,20,0),
                                child: Text(installationListModelObject[index].status == "2" ? " Pending" : " Approved", style: TextStyle(color: installationListModelObject[index].status == "2" ? Color(0xffFEB211) : Colors.green),),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                child: Container(
                                  height: height*0.06,
                                  width: width*0.65,
                                  child: Column(
                                    children: [
                                      Text("${installationListModelObject[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                      Text("${installationListModelObject[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,),overflow: TextOverflow.ellipsis),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 1,
                                  width: width*0.2,
                                  color: Colors.grey,
                                ),
                                Text("Request Approval Summary", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                Container(
                                  height: 1,
                                  width: width*0.2,
                                  color: Colors.grey,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.04,height*0.01,0,0),
                                    child: Row(
                                      children: [
                                        Text("Element:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        Text(" ${installationListModelObject[index].brandingElementName}", style: TextStyle(fontSize: 16, color: Colors.grey,),overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.04,height*0.005,0,0),
                                    child: Row(
                                      children: [
                                        Text("Dimension:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        Text(" ${installationListModelObject[index].dimensions["width"]} W x ${installationListModelObject[index].dimensions["height"]} H", style: TextStyle(fontSize: 16, color: Colors.grey,),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.04,height*0.005,0,0),
                                    child: Row(
                                      children: [
                                        Text("Cost total:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        Text(" ₹ ${installationListModelObject[index].cost}", style: TextStyle(fontSize: 16, color: Colors.grey,),),
                                      ],
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  color: Colors.transparent,
                                  height: height*0.1,
                                  width: height*0.1,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: installationListModelObject[index].surveyImages.length,
                                    itemBuilder: (context, int i){
                                      return Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(child: Image.network("${installationListModelObject[index].surveyImages[i]}", height: height*0.1, width: height*0.1,)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                            child: SizedBox(
                              height: height*0.05,
                              width: width*0.8,
                              child: ElevatedButton(
                                onPressed: () async{
                                  await InstallationDetailApi_ApiCall.installationDetailApi(context, installationListModelObject[index].id);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RequestStatus()));
                                },
                                child: Text("View Status", style: TextStyle(fontSize: 18, color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  backgroundColor: Color(0xff006BD8),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ), onRefresh: () async{
              await InstallationListApi_ApiCall.installationListApi(context, status);
              setState(() {});
            },
            ),
          ),
         ),
        ],
      ),
    );
  }
}




