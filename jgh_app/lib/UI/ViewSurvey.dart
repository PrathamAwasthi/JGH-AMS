import 'package:flutter/material.dart';
import 'package:jgh_app/Model/ViewSurvey_Model.dart';
import 'package:jgh_app/UI/ViewStatus.dart';

import '../Api_Call/SurveyListApi.dart';


class ViewSurveyPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return ViewSurveyPageState();
  }
}

class ViewSurveyPageState extends State<ViewSurveyPage>{
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.085),
        child: Container(
          color: Color(0xff273894),
          child: Container(
            height: height*0.085,
            width: width*0.8,
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                Text("Retailer branding request", style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Color(0xffe6eeff),
          ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                    Text("Total Requests:${viewSurveyModelObject.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Spacer(),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
            Expanded(child: Container(
              width: width,
              color: Colors.transparent,
              child: RefreshIndicator(child: ListView.builder(
                itemCount: viewSurveyModelObject.length,
                itemBuilder: (context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: height*0.29,
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
                                    width: width*0.15,
                                    decoration: BoxDecoration(
                                      color: Color(0xffEBEEFF),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("Req#0${index+1}", style: TextStyle(color: Color(0xff273894)),)),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.circle,size: 10, color: Color(0xffFEB211),),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Text(" ${viewSurveyModelObject[index].statusLabel}", style: TextStyle(color: Color(0xffFEB211)),),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: width*0.65,
                                    child: Column(
                                      children: [
                                        Text("${viewSurveyModelObject[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text("${viewSurveyModelObject[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,),),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.01,0,0),
                                  child: Column(
                                    children: [
                                      Text("Branding requirement:", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                  child: Column(
                                    children: [
                                      Text("${viewSurveyModelObject[index].brandingElementName}", style: TextStyle(color: Colors.grey, fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                              child: SizedBox(
                                height: height*0.05,
                                width: width*0.8,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStatusPage(index)));
                                  },
                                  child: Text("Start Survey", style: TextStyle(fontSize: 18, color: Colors.white),),
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
                await SurveyListApi_ApiCall.surveyListApi(context);
                setState(() {});
              },
              ),
            ),),
          ],
        ),
      ),
    ),
    );
  }
}











