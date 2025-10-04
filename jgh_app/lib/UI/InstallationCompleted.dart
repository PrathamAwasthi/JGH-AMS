import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/InstallationCompletedApi.dart';
import 'package:jgh_app/Model/InstallationCompletedModel.dart';
import 'package:jgh_app/UI/Pament%20Status.dart';


class InstallationCompleted extends StatefulWidget{
  State<StatefulWidget> createState(){
    return InstallationCompletedState();
  }
}

class InstallationCompletedState extends State<InstallationCompleted>{
  int i = 1;

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
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
                Text("Installation Status", style: TextStyle(color: Colors.white, fontSize: 18),),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height*0.07,
                width: width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(width: width*0.67,color:Colors.transparent,child: Text("Installation Completed: ${InstallationCompletedModel.count}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                      IconButton(
                          onPressed:  i != 1 ? () async{
                            i--;
                            await InstallationCompletedApi_ApiCall.installationCompletedApiApi(context, i.toString(), check: false);
                            setState(() {});
                          } : null,
                          icon: Icon(Icons.arrow_back,size: 18,),
                      ),
                      Text("${i}", style: TextStyle(fontSize: 16),),
                      IconButton(
                          onPressed: 10 <= installationCompletedModelObject.length ? () async{
                        i++;
                        await InstallationCompletedApi_ApiCall.installationCompletedApiApi(context, i.toString(), check: false);
                        setState(() {});
                      } : null,
                          icon: Icon(Icons.arrow_forward, size: 18,),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
              Container(
                height: height*0.78,
                width: width,
                color: Colors.transparent,
                child: RefreshIndicator(child: ListView.builder(
                  itemCount: installationCompletedModelObject.length,
                  itemBuilder: (context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: height*0.3,
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
                                      decoration: BoxDecoration(
                                        color: Color(0xffEBEEFF),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(child: Text("Req#0${installationCompletedModelObject[index].id}", style: TextStyle(color: Color(0xff273894)),)),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff28A745)
                                          ),
                                        ),
                                        Text(" ${installationCompletedModelObject[index].statusLabel}", style: TextStyle(color: Color(0xff28A745)),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                    child: Container(
                                      width: width*0.7,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Text("${installationCompletedModelObject[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                          Text("${installationCompletedModelObject[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,),overflow: TextOverflow.ellipsis,),
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width*0.55,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.05,0),
                                            child: Row(
                                              children: [
                                                Text("Element:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                Text(" ${installationCompletedModelObject[index].brandingElementName}", style: TextStyle(fontSize: 14, color: Colors.grey,), overflow: TextOverflow.ellipsis,),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0,height*0.005,width*0.05,0),
                                            child: Row(
                                              children: [
                                                Text("Dimension:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                Text(" ${installationCompletedModelObject[index].dimensions["width"]} W x ${installationCompletedModelObject[index].dimensions["height"]} H", style: TextStyle(fontSize: 14, color: Colors.grey,),overflow: TextOverflow.ellipsis,),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0,height*0.005,width*0.05,0),
                                            child: Row(
                                              children: [
                                                Text("Cost total:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                Text(" ${installationCompletedModelObject[index].cost}", style: TextStyle(fontSize: 14, color: Colors.grey,),overflow: TextOverflow.ellipsis,),
                                              ],
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ), onRefresh: () async{
                  await InstallationCompletedApi_ApiCall.installationCompletedApiApi(context, i.toString(), check: false);
                  setState(() {});
                },
                ),
              ),
            ],
          ),
        )
      ),
    ));
  }
}


