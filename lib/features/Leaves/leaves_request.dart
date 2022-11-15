import 'package:erp_prepseed/features/Leaves/dashboard.dart';
import 'package:erp_prepseed/features/Leaves/leave_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LeaveAndReportPage extends StatelessWidget {
  const LeaveAndReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (BuildContext context, Widget? child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  LeaveAndReport(),
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

  bool isMultipleDay = false;
  bool isFullDay = false;

  DateTime? fromDate;
  DateTime? toDate;
  var differ;
  List days = [];
  List fullDays = [];
  List type = [];
  List leavesData = [];
  List<Map> leavesReq = [];
  Map leavesMap = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getScreen(),
      ),
    );
  }

  /*GetFirstScreen() {
    return Expanded(
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context,index)=>Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 15.0),
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
                                  const Text("Wed, 16 Dec",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 10.h,),
                                  const Text("Half Day Application",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w200,color:  Color(0xff282A32)),),
                                  SizedBox(height: 10.h,),
                                  const Text("Casual",style: TextStyle(color: Color(0xffFFBE3B)),),
                                ],),
                            )
                          ],),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: const Color(0xffFEEBF5),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Padding(
                                padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                                child: Text("Declined",style: const TextStyle(color: Color(0xffF79293)),),
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
  }*/

  getScreen() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
            child: const Icon(Icons.arrow_back_ios_new,size: 15.0,color: Colors.black,),
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LeaveLists())
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text('New Leave',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
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
                         //   Text('Leave For',style: textStyle,),
                            Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Text("Single Day",style: textStyle,),
                                  Switch(value: isMultipleDay, onChanged: toggleSwitch),
                                  Text("Multiple Day",style: textStyle,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(indent: 20,),
                        isMultipleDay != true
                         ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           // Text('Leave Duration',style: textStyle,),
                            Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Text("Half Day",style: textStyle,),
                                  Switch(value: isFullDay, onChanged: fullDay),
                                  Text("Full Day",style: textStyle,),
                                ],
                              ),
                            ),
                          ],
                        )
                        : Container(),
                        isMultipleDay!= true ?  const Divider(indent: 20,) : Container(),
                        Row(
                          children: [
                            Image.asset("assets/images/Seelect Date Icon.png"),
                            Expanded(
                              child: Container(
                                height: 45.0,
                                margin: const EdgeInsets.all( 10.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: fromController, //editing controller of this TextField
                                  decoration:  InputDecoration(
                                      contentPadding: const EdgeInsets.all(10.0),
                                      border: const OutlineInputBorder(
                                        borderRadius:  BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                      labelText: "From Date",
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
                                        fromDate = pickedDate;
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
                        const Divider(indent: 20,),
                        isMultipleDay ? Row(
                          children: [
                            Image.asset("assets/images/Seelect Date Icon.png"),
                            Expanded(
                              child: Container(
                                height: 45.0,
                                margin: const EdgeInsets.all( 10.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: toController, //editing controller of this TextField
                                  decoration:  InputDecoration(
                                      contentPadding: const EdgeInsets.all(10.0),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                      labelText: "To Date",
                                      labelStyle: textStyle  //label text of field
                                  ),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: fromDate!, //get today's date
                                        firstDate: fromDate!, //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                      //You can format date as per your need
                                      setState(() {
                                        toDate = pickedDate;
                                        differ = (toDate!.difference(fromDate!).inDays + 1);
                                        toController.text = formattedDate;
                                         days = List.generate(differ, (i) => DateTime(fromDate!.year, fromDate!.month, fromDate!.day + (i)));//set foratted date to TextField value.
                                        print(days);
                                        days.forEach((element) {
                                          leavesMap["date"] = DateFormat('dd-MM-yyyy').format(element);
                                          leavesMap["type"] = "Casual";
                                          leavesMap['fullDay'] = true;
                                          leavesReq.add(leavesMap);
                                          leavesMap = {};
                                        });
                                        print(leavesMap);
                                        print(leavesReq);
                                      });
                                      print(fullDays);
                                      print(type);
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              )
                            ),
                          ],
                        ) : Container(),
                        isMultipleDay ?  const Divider(indent: 20,) : Container(),
                        isMultipleDay ? Container() : Row(
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
                                          style:const TextStyle(
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
                        isMultipleDay ?  Container() : const Divider(indent: 20,),
                        days.length >= 1
                        ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: days.length,
                            itemBuilder: (context,index){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('dd-MM-yyyy').format(days[index]).toString()),
                                  Container(
                                      padding: const EdgeInsets.all(10.0),
                                      height: 40.0,
                                       width: 80.0,
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
                                        value: leavesReq[index]["type"],
                                        isExpanded: true,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        iconSize: 20.0,
                                        underline: Container(),
                                        items: <String>['Casual', 'Medical', 'Unpaid'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value.toString(),
                                            child: Text(value.toString(),
                                              style:const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0
                                              ),),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue.toString();
                                            leavesReq[index]["type"] = dropdownValue;
                                            print(dropdownValue);
                                          });
                                        },
                                      )
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Full Day",style: textStyle,),
                                        Switch(value: leavesReq[index]["fullDay"],
                                            onChanged: (bool value){
                                                if(leavesReq[index]["fullDay"] == false)
                                                {
                                                  setState(() {
                                                    leavesReq[index]["fullDay"] = true;
                                                  });
                                                  print('half Day');
                                                }
                                                else
                                                {
                                                  setState(() {
                                                    leavesReq[index]["fullDay"] = false;
                                                  });
                                                  print('full Day');
                                                }
                                              }
                                        ),
                                        Text("Half Day",style: textStyle,),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                        )
                        : Container(),
                        Row(
                          children: [
                            Image.asset("assets/images/Cause.png"),
                            // SizedBox(width: 20,),
                            Expanded(
                                child:   Container(
                                  margin: const EdgeInsets.all( 10.0),
                                  child:  TextField(
                                    maxLines: 3,
                                    controller: reasonController,
                                    style: const TextStyle(color: Colors.black,fontSize: 14.0),
                                    decoration:  InputDecoration(
                                        hintText: "Describe here (Optional)",
                                        hintStyle: textStyle,
                                        contentPadding: const EdgeInsets.all(10.0),
                                        border: const OutlineInputBorder(
                                          borderRadius:  BorderRadius.all(Radius.circular(10.0)),
                                        )),
                                  ),
                                )
                            ),
                          ],
                        ),

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
            margin: const EdgeInsets.only(bottom: 15.0),
            height: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            width: double.infinity,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  primary: const Color(0xff437BF1)),
              onPressed: (){
                //List<dynamic>.from(leavesData.map((x) => x.toJson()));
                for(int i = 0; i < days.length; i++){
                 // leavesData[i] = DateFormat('MM-dd-yyyy').format(days[i]) + type[i] + fullDays[i];
                }
                print(leavesReq);
                List list = [];
                leavesReq.forEach((element) {
                  list.add(element.values.toList());
                });
                print(list);
                fromController.clear();
                toController.clear();
                reasonController.clear();
              setState(() {
                dropdownValue == null;
                days = [];
                type = [];
                fullDays = [];
              });
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomeScreen()));
              },
              child: const Text("Apply For Leave"),
            ),
          ),
        ),
      ],
    );
  }
  void toggleSwitch(bool value) {

    if(isMultipleDay == false)
    {
      setState(() {
        isMultipleDay = true;
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isMultipleDay = false;
      });
      print('Switch Button is OFF');
    }
  }
   fullDay(bool value) {

    if(value == false)
    {
      setState(() {
        value = true;
      });
      print('Full Day');
    }
    else
    {
      setState(() {
        value = false;
      });
      print('Half Day');
    }
  }
  TextStyle textStyle = const TextStyle(
  color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500,
  );
}