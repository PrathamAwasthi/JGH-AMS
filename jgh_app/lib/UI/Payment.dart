import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/PaymentListApi.dart';
import 'package:jgh_app/Api_Call/paymentStatusDetailApi.dart';
import 'package:jgh_app/Model/PaymentListModel.dart';


class Payment extends StatefulWidget{
  State<StatefulWidget> createState(){
    return PaymentState();
  }
}

class PaymentState extends State<Payment>{
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
                  Text("Payments: ${paymentListModelObjects.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
              itemCount: paymentListModelObjects.length,
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
                                  decoration: BoxDecoration(
                                    color: Color(0xffEBEEFF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Text("Req#${paymentListModelObjects[index].userId}", style: TextStyle(color: Color(0xff273894)),)),
                                ),
                              ),
                              Spacer(),
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
                                      Text("${paymentListModelObjects[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                      Text("${paymentListModelObjects[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,),),
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
                                  width: width*0.85,
                                  color: Colors.grey,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                child: Image.asset("assets/iconoir_shop.png",scale: 0.8,),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                child: Text("${paymentListModelObjects[index].shopName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                        child: Icon(Icons.location_on_outlined, color: Color(0xffBEBEBE),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                        child: Container(
                                          height: height*0.05,
                                          width: width*0.5,
                                          color: Colors.white,
                                          child: Align(alignment: Alignment.centerLeft,child: Text("${paymentListModelObjects[index].address}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),overflow: TextOverflow.clip,)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                        child: Icon(Icons.phone, color: Color(0xffBEBEBE),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                        child: Container(
                                          height: height*0.05,
                                          width: width*0.5,
                                          color: Colors.white,
                                          child: Align(alignment: Alignment.centerLeft,child: Text("+91 ${paymentListModelObjects[index].mobileNumber}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: height*0.09,
                                width: width*0.3,
                                color: Colors.transparent,
                                child: Image.network("https://beta.jghmagic.com/images/geo_tagimage_images/geo_tagimage_mechanic_46602.jpeg"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                            child: SizedBox(
                              height: height*0.05,
                              width: width*0.8,
                              child: ElevatedButton(
                                onPressed: () async{
                                  await PaymentStatusDetailApi_ApiCall.paymentStatusDetailApi(context, paymentListModelObjects[index].userId);
                                },
                                child: Text("View Payment Status", style: TextStyle(fontSize: 18, color: Colors.white),),
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
              await PaymentListApi_ApiCall.paymentListApi(context);
            },
            ),
          ),),
        ],
      ),
    );
  }
}




