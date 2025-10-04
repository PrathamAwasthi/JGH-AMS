import 'package:flutter/material.dart';
import 'package:jgh_app/Api_Call/paymentStatusDetailApi.dart';
import 'package:jgh_app/Model/PaymentStatusDetailsModel.dart';
import 'package:jgh_app/UI/RaiseTicket.dart';


class PaymentStatus extends StatefulWidget{
  String ownerId;
  PaymentStatus(this.ownerId, {super.key});
  State<StatefulWidget> createState() {
    return PaymentStatusState();
  }
}

class PaymentStatusState extends State<PaymentStatus>{

  DateTime selectedDate = DateTime.now();

  DateTimeRange? selectedDateRange;

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ?? DateTimeRange(
        start: DateTime.now().subtract(Duration(days: 7)),
        end: DateTime.now(),
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select a date range',
      saveText: "Apply",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple, // Header background & button color
              onPrimary: Colors.white,     // Header text color
              surface: Colors.white,       // Dialog background
              onSurface: Colors.black,     // Default text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.deepPurple, // "Cancel" and "Apply" text color
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      selectedDateRange = picked;

      await PaymentStatusDetailApi_ApiCall.paymentStatusDetailApi(
        context,
        widget.ownerId,
        startDate: "${selectedDateRange!.start.year}-${selectedDateRange!.start.month}-${selectedDateRange!.start.day}",
        endDate: "${selectedDateRange!.end.year}-${selectedDateRange!.end.month}-${selectedDateRange!.end.day}",
        navigate: "0",
      );

      setState(() {});
    }
  }

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
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("All Payment:${paymentStatusDetailsModelObject.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Spacer(flex: 9,),
                    IconButton(
                      onPressed: (){
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      icon: Icon(Icons.filter_alt_outlined),
                      onSelected: (value) async{
                        if(value != "0"){
                          await PaymentStatusDetailApi_ApiCall.paymentStatusDetailApi(context, widget.ownerId, status: value, navigate: "0");
                        }else{
                          await PaymentStatusDetailApi_ApiCall.paymentStatusDetailApi(context, widget.ownerId, navigate: "0");
                        }
                        setState(() {});
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: "0",
                          child: Text('All Payment'),
                        ),
                        const PopupMenuItem(
                          value: '1',
                          child: Text('Paid'),
                        ),
                        const PopupMenuItem(
                          value: '3',
                          child: Text('Initiated'),
                        ),
                        const PopupMenuItem(
                            value: '2',
                            child: Text("On Hold")
                        ),
                      ],
                    ),
                    Spacer(flex: 1,)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
            Expanded(child: Container(
              width: width,
              color: Colors.transparent,
              child: RefreshIndicator(child: ListView.builder(
                itemCount: paymentStatusDetailsModelObject.length,
                itemBuilder: (context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: paymentStatusDetailsModelObject[index].paymentStatusLabel == "On-Hold" ? height*0.565 : height*0.54,
                      width: width,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffEBEEFF),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("Req#${paymentStatusDetailsModelObject[index].id}", style: TextStyle(color: Color(0xff273894)),)),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: paymentStatusDetailsModelObject[index].paymentStatusLabel == "Initiated" ? Color(0xffC48603) : paymentStatusDetailsModelObject[index].paymentStatusLabel == "On-Hold" ? Color(0xffB80105) : Color(0xff28A745),
                                    ),
                                  ),
                                  Text(" ${paymentStatusDetailsModelObject[index].paymentStatusLabel}", style: TextStyle(color: paymentStatusDetailsModelObject[index].paymentStatusLabel == "Initiated" ? Color(0xffC48603) : paymentStatusDetailsModelObject[index].paymentStatusLabel == "On-Hold" ? Color(0xffB80105) : Color(0xff28A745)),),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                  child: Container(
                                    width: width*0.65,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Text("${paymentStatusDetailsModelObject[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                        Text("${paymentStatusDetailsModelObject[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,), overflow: TextOverflow.ellipsis,),
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
                                  Text("Installation completed", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
                                      padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.05,0),
                                      child: Row(
                                        children: [
                                          Text("Element:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Text(" ${paymentStatusDetailsModelObject[index].brandingElementName}", style: TextStyle(fontSize: 14, color: Colors.grey,),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,height*0.005,width*0.05,0),
                                      child: Row(
                                        children: [
                                          Text("Dimension:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Text(" ${paymentStatusDetailsModelObject[index].dimensions["width"]} W x ${paymentStatusDetailsModelObject[index].dimensions["height"]} H", style: TextStyle(fontSize: 14, color: Colors.grey,),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,height*0.005,width*0.05,0),
                                      child: Row(
                                        children: [
                                          Text("Cost total:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Text(" ${paymentStatusDetailsModelObject[index].cost}", style: TextStyle(fontSize: 14, color: Colors.grey,),),
                                        ],
                                      ),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                Image.asset("assets/image (1).png"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  Text("Payment Details", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
                              padding: EdgeInsets.fromLTRB(width*0.03,0,0,0),
                              child: Row(
                                children: [
                                  Text("Payment Date: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(" ${paymentStatusDetailsModelObject[index].paymentDate}", style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width*0.03,height*0.005,0,0),
                              child: Row(
                                children: [
                                  Text("Installation Date: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(" ${paymentStatusDetailsModelObject[index].installationDate}", style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width*0.03,height*0.005,0,0),
                              child: Row(
                                children: [
                                  Text("Payment Amount: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(" ${paymentStatusDetailsModelObject[index].cost}", style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width*0.03,height*0.005,0,0),
                              child: Row(
                                children: [
                                  Text("Remarks: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(paymentStatusDetailsModelObject[index].paymentStatusLabel == "Initiated" ? "In progress" : paymentStatusDetailsModelObject[index].paymentStatusLabel == "On-Hold" ? "Awating internal approval \nfrom finance team" : "Payment recived successfully", style: TextStyle(color: Color(0xff28A745)),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                              child: SizedBox(
                                height: height*0.05,
                                width: width*0.8,
                                child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RaiseTicket()));
                                  },
                                  child: Text("Raise ticket", style: TextStyle(fontSize: 18, color: Colors.white),),
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
                await PaymentStatusDetailApi_ApiCall.paymentStatusDetailApi(context, widget.ownerId, navigate: "0");
                setState(() {});
              },
              ),
            ),),
          ],
        ),
      ),
    ));
  }
}








