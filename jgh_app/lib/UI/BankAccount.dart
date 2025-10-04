import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/BankAccountList.dart';
import 'package:jgh_app/Api_Call/DeleteBankAccountApi.dart';
import 'package:jgh_app/Model/BankAccountListModel.dart';
import 'package:jgh_app/UI/AddBankAccount.dart';
import 'RaiseTicket.dart';


class BankAccount extends StatefulWidget{
  State<StatefulWidget> createState(){
    return BackButtonState();
  }
}

class BackButtonState extends State<BankAccount>{

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height*0.085),
          child: Container(
            height: height*0.1,
            color: Color(0xff273894),
            child: Row(
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                Text("My Banks", style: TextStyle(color: Colors.white, fontSize: 18),),
                Spacer(),
                Padding(
               padding: EdgeInsets.fromLTRB(0,0,0,0),
                   child: IconButton(
                       onPressed: () async{
                       }, icon: Icon(Icons.notifications_none, color: Colors.white, size: 32,)),
                 ),
                Padding(
                   padding: EdgeInsets.fromLTRB(width*0.01,0,width*0.05,0),
                   child: IconButton(
                       onPressed: () async{
                         Navigator.push(context, MaterialPageRoute(builder: (context) => RaiseTicket()));
                       }, icon: Icon(Icons.support_agent, color: Colors.white, size: 32,)),
                 ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
            child: Container(
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
          child: bankAccountListModelObjects.isEmpty ? Center(child: Text("You have not added any bank account yet!", style: TextStyle(color: Colors.grey),)) :
          ListView.separated(
            itemCount: bankAccountListModelObjects.length,
            itemBuilder: (context, int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Container(
                    height: height*0.06,
                    width: height*0.06,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text("${bankAccountListModelObjects[index].bankName[0]}${bankAccountListModelObjects[index].bankName[1]}${bankAccountListModelObjects[index].bankName[2]}", style: TextStyle( color: Colors.white, fontSize: 16),)),
                  ),
                  title: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text("${bankAccountListModelObjects[index].bankName}",style: TextStyle(color: Colors.black),),
                        Text("XXXX${bankAccountListModelObjects[index].accountNumber[bankAccountListModelObjects[index].accountNumber.length-4]}${bankAccountListModelObjects[index].accountNumber[bankAccountListModelObjects[index].accountNumber.length-3]}${bankAccountListModelObjects[index].accountNumber[bankAccountListModelObjects[index].accountNumber.length-2]}${bankAccountListModelObjects[index].accountNumber[bankAccountListModelObjects[index].accountNumber.length-1]}",),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) async{
                      if(value == "1"){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddBankAccount(index: index)));
                      }else if(value == "2"){
                        await DeleteBankAccount_ApiCall.deleteBankAccountApi(context, id: bankAccountListModelObjects[index].id);
                        setState(() {});
                      }
                      setState(() {});
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: '1',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: '2',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, int index){
              return Padding(
                padding: EdgeInsets.fromLTRB(width*0.05,0,width*0.05,0),
                child: Container(
                  width: width,
                  height: 1,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
        onRefresh: () async{
              await BankAccountList_ApiCall.bankAccountListApi(context, check: false);
              setState(() {});
            }),
        bottomNavigationBar: PreferredSize(
            preferredSize: Size.fromHeight(height*0.085),
            child: Container(
              height: height*0.085,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Color(0xffe6eeff),
                ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: height*0.06,
                    width: width*0.8,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBankAccount()));
                        },
                        child: Text("ADD A BANK", style: TextStyle(color: Color(0xff273894)),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xff273894),),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}

