import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/AddBankAccountApi.dart';
import 'package:jgh_app/Api_Call/UpdateBankAccountApi.dart';
import 'package:jgh_app/Model/BankAccountListModel.dart';


class AddBankAccount extends StatefulWidget{
  int? index;
  AddBankAccount({super.key, this.index});
  State<StatefulWidget> createState(){
    return AddBackButtonState();
  }
}

class AddBackButtonState extends State<AddBankAccount>{

  TextEditingController accountHolderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController upiId = TextEditingController();
  TextEditingController ifscCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index != null){
      accountHolderName.text = bankAccountListModelObjects[widget.index!].accountHolderName;
      bankName.text = bankAccountListModelObjects[widget.index!].bankName;
      accountNumber.text = bankAccountListModelObjects[widget.index!].accountNumber;
      upiId.text = bankAccountListModelObjects[widget.index!].upiId == "null" ? "" : bankAccountListModelObjects[widget.index!].upiId;
      ifscCode.text = bankAccountListModelObjects[widget.index!].ifscCode;
    }
  }

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
                Text("Add Bank Account", style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
            ),
          ),
        ),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.05,width*0.4,0),
                  child: Text("Enter Your Bank Details", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                  child: TextField(
                    controller: accountHolderName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Account Holder Name*", style: TextStyle(color: Colors.grey,),),
                    ),
                    onChanged: (value){
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                  child: TextField(
                    controller: bankName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Bank Name*", style: TextStyle(color: Colors.grey,),),
                    ),
                    onChanged: (value){
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                  child: TextField(
                    controller: accountNumber,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Account Number*", style: TextStyle(color: Colors.grey,),),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                  child: TextField(
                    controller: upiId,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("UPI ID", style: TextStyle(color: Colors.grey,),),
                    ),
                    onChanged: (value){
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,height*0.02,width*0.05,0),
                  child: TextField(
                    controller: ifscCode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("IFSC Code*", style: TextStyle(color: Colors.grey,),),
                    ),
                    onChanged: (value){
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                  child: SizedBox(
                    height: height*0.06,
                    width: width*0.9,
                    child: ElevatedButton(
                        onPressed: accountHolderName.text.length != 0  && bankName.text.length != 0 && accountNumber.text.length != 0 && ifscCode.text.length != 0 ? () async{
                          if(widget.index == null){
                            await AddBankAccount_ApiCall.addBankAccountApi(
                              context,
                              accountHolderName: accountHolderName.text.trim().toString(),
                              bankName: bankName.text.trim().toString(),
                              upi_Id: upiId.text.trim().toString(),
                              accountNumber: accountNumber.text.trim().toString(),
                              ifscCode: ifscCode.text.trim().toString(),
                            );
                          }else{
                            await UpdateBankAccountApi_ApiCall.updateBankAccountApi(
                              context,
                              id: bankAccountListModelObjects[widget.index!].id,
                              accountHolderName: accountHolderName.text.trim().toString(),
                              bankName: bankName.text.trim().toString(),
                              upi_Id: upiId.text.trim().toString(),
                              accountNumber: accountNumber.text.trim().toString(),
                              ifscCode: ifscCode.text.trim().toString(),
                            );
                          }
                        } : null,
                        child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Color(0xff273894),
                      ),
                    ),
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