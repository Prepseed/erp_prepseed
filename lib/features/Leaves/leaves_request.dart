import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LeaveAndReportPage extends StatelessWidget {
  LeaveAndReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LeaveAndReport(),
        );
      },
    );
  }
}
class LeaveAndReport extends StatefulWidget {
  const LeaveAndReport({Key? key}) : super(key: key);

  @override
  State<LeaveAndReport> createState() => _LeaveAndReportState();
}

class _LeaveAndReportState extends State<LeaveAndReport> {

  String? dropdownValue;
  TextEditingController reasonController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetScreen(),
      ),
    );
  }

  GetFirstScreen() {
    return Expanded(
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context,index)=>Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(color: Colors.white,width: 5,height: 7,),
                                Container(color: Colors.blue,width: 2,height: 10,),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Wed, 16 Dec",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 10.h,),
                                  Text("Half Day Application",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w200,color: Color(0xff282A32)),),
                                  SizedBox(height: 10.h,),
                                  Text("Casual",style: TextStyle(color: Color(0xffFFBE3B)),),
                                ],),
                            )
                          ],),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0,bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffFEEBF5),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                                child: Text("Declined",style: TextStyle(color: Color(0xffF79293)),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  GetScreen() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Icon(Icons.arrow_back_ios_new,size: 15.0,color: Colors.black,),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text('New Leave',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Leave For',style: textStyle,),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Text("Half Day",style: textStyle,),
                                  Switch(value: isSwitched, onChanged: toggleSwitch),
                                  Text("Full Day",style: textStyle,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/Type.png"),
                           // SizedBox(width: 20,),
                            Expanded(
                              child:   Container(
                                  padding: const EdgeInsets.all(10.0),
                                  height: 40.0,
                                  // width: 150.0,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Colors.black45),
                                    // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black45,offset: Offset(3,3))]
                                  ),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Leave Type",
                                        style:textStyle),
                                    // borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    value: dropdownValue,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    iconSize: 20.0,
                                    underline: Container(),
                                    items: <String>['Casual', 'Medical', 'Unpaid'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(value.toString(),
                                          style:TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0
                                          ),),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue.toString();
                                        print(dropdownValue);
                                      });
                                    },
                                  )
                              ),
                            ),
                          ],
                        ),
                        Divider(indent: 20,),
                        Row(
                          children: [
                            Image.asset("assets/images/Cause.png"),
                           // SizedBox(width: 20,),
                            Expanded(
                              child:   Container(
                                margin: EdgeInsets.all( 10.0),
                                height: 40.0,
                                child:  TextField(
                                  controller: reasonController,
                                  style: const TextStyle(color: Colors.black,fontSize: 14.0),
                                  decoration: const InputDecoration(
                                      hintText: "Describe here (Optional)",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      )),
                                ),
                              )
                            ),
                          ],
                        ),
                        Divider(indent: 20,),
                        Row(
                          children: [
                            Image.asset("assets/images/Seelect Date Icon.png"),
                            Expanded(
                              child: Container(
                                height: 45.0,
                                margin: EdgeInsets.all( 10.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: fromController, //editing controller of this TextField
                                  decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                      labelText: "Select Date",
                                      labelStyle: textStyle//label text of field
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        fromController.text = formattedDate; //set foratted date to TextField value.
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              )
                            ),
                          ],
                        ),
                        Divider(indent: 20,),
                        Row(
                          children: [
                            Image.asset("assets/images/Seelect Date Icon.png"),
                            Expanded(
                              child: Container(
                                height: 45.0,
                                margin: EdgeInsets.all( 10.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: toController, //editing controller of this TextField
                                  decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                      labelText: "Enter Date",
                                      labelStyle: textStyle  //label text of field
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need

                                      setState(() {
                                        toController.text = formattedDate; //set foratted date to TextField value.
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Leave For',style: textStyle,),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Text("Half Day",style: textStyle,),
                                  Switch(value: isSwitched, onChanged: toggleSwitch),
                                  Text("Full Day",style: textStyle,),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],),
                  ),
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 14),
            width: double.infinity,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  primary: Color(0xff437BF1)),
              onPressed: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomeScreen()));
              },
              child: Text("Apply For Leave"),
            ),
          ),
        ),
      ],
    );
  }
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }
  TextStyle textStyle = TextStyle(
  color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500,
  );
}