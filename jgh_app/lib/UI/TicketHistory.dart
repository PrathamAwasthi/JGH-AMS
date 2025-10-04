import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/getTicketDetailsApi.dart';
import 'package:jgh_app/ScreenState/TicketHistoryState.dart';
import 'package:jgh_app/UI/CreateTicket.dart';
import 'package:provider/provider.dart';
import '../Model/TicketList_Model.dart';

class TicketHistory extends StatefulWidget{
  State<StatefulWidget> createState(){
    return TicketStateHistory();
  }
}

TicketHistoryState? ticketHistoryState;
class TicketStateHistory extends State<TicketHistory>{

  TextEditingController searchData = TextEditingController();
  List<String> filteredItems = [];

  void _filterItems() {
    List<String> allItems = [];
    for(int i =0;i<ticketListModelObject.length;i++){
      allItems.add(ticketListModelObject[i].title);
    }
    final query = searchData.text.toLowerCase();
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }



  Widget build(BuildContext){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: ChangeNotifierProvider<TicketHistoryState>(
          create: (context) => TicketHistoryState(),
          child: Consumer<TicketHistoryState>(builder: (context, provider, child){
            ticketHistoryState = provider;
            return Scaffold(
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
                          Text("Ticket History", style: TextStyle(color: Colors.white, fontSize: 18),),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                      child: Center(
                        child: TextField(
                          controller: searchData,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: "Search ticket",
                            suffixIcon: Icon(Icons.search_rounded, size: 38,),
                          ),
                          onChanged: (value){
                            _filterItems();
                          },
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        searchData.text.trim().toString() != "" ? Container(
                          height: height*0.2,
                          width: width,
                          color: Colors.white,
                          child: ListView.builder(
                            itemCount: filteredItems.length,
                            itemBuilder: (context, int index){
                              return Stack(
                                children: [
                                  ListTile(
                                    title: Text(filteredItems[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(
                                    height: height*0.07,
                                    width: width,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        for(int i=0;i<ticketListModelObject.length;i++){
                                          if(filteredItems[index] == ticketListModelObject[i].title){
                                            await GetTicketDetails_ApiCall.getTicketDetails(context, ticketListModelObject[i].id);
                                            searchData.clear();
                                          }
                                        }
                                      },
                                      child: Text(""),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(),
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ) : Container(),
                      ],
                    ),
                    Expanded(child: Container(
                      width: width,
                      color: Colors.transparent,
                      child: ListView.builder(
                          itemCount: ticketListModelObject.length,
                          itemBuilder: (context, int index){
                            return Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.02,0,width*0.02,0),
                                  child: SizedBox(
                                    height: height*0.2,
                                    width: width,
                                    child: Card(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Icon(Icons.calendar_view_day, color: Color(0xff273894),),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff7287B8),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Container(
                                                  height: height*0.025,
                                                  width: width*0.5,
                                                  color: Colors.transparent,
                                                  child: Text(" Ticket #${ticketListModelObject[index].id}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: height*0.025,
                                                  width: width*0.2,
                                                  color: Colors.transparent,
                                                  child: Text(ticketListModelObject[index].createdAt, style: TextStyle(fontSize: width*0.035),),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height*0.025,
                                            width: width*0.85,
                                            color: Colors.transparent,
                                            child: Text("${ticketListModelObject[index].title}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                          ),
                                          Container(
                                            height: height*0.025,
                                            width: width*0.85,
                                            color: Colors.transparent,
                                            child: Text("${ticketListModelObject[index].description}", style: TextStyle(fontSize: 16,),overflow: TextOverflow.ellipsis,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: height*0.05,
                                                  width: width*0.27,
                                                  child: Card(
                                                    color: Colors.grey.shade300,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: height*0.015,
                                                          width: height*0.015,
                                                          decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            shape: BoxShape.circle,
                                                          ),
                                                        ),
                                                        Text(" Low", style: TextStyle(fontSize: 16),),
                                                      ],
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  height: height*0.05,
                                                  width: width*0.27,
                                                  child: Card(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(0),
                                                          child: Icon(Icons.circle, color: ticketListModelObject[index].status == "0" ? Colors.green : Colors.red, size: 18,),
                                                        ),
                                                        ticketListModelObject[index].status == "0" ? Text(" Open", style: TextStyle(fontSize: 16, color: Colors.black),) : Text(" Close", style: TextStyle(fontSize: 16, color: Colors.black),),
                                                      ],
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.02,0,width*0.02,0),
                                  child: SizedBox(
                                    height: height*0.2,
                                    width: width,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        await GetTicketDetails_ApiCall.getTicketDetails(context, ticketListModelObject[index].id, check: false, ticketHistoryCheck: true);
                                      },
                                      child: Text(""),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width*0.9,
                        height: height*0.05,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTicket()));
                          },
                          child: Text("+ Raise a New Ticket", style: TextStyle(color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xffFBB82A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
   );
  }
}







