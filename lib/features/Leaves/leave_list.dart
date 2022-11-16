import 'package:erp_prepseed/features/Leaves/dashboard.dart';
import 'package:erp_prepseed/features/Leaves/leave_req_provider.dart';
import 'package:erp_prepseed/features/Leaves/leaves_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constant/sharedPref.dart';

class LeaveLists extends StatefulWidget {
  const LeaveLists({Key? key}) : super(key: key);

  @override
  State<LeaveLists> createState() => _LeaveListsState();
}

class _LeaveListsState extends State<LeaveLists> {

  @override
  Widget build(BuildContext context) {
    
    final provMdl = Provider.of<LeaveReqProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<LeaveReqProvider>(
            builder: (context,data,_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               // padding: EdgeInsets.all(10.0),
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
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Dashboard())
                      );
                    },
                  ),
                  provMdl.leavesModel.leaves!.isNotEmpty
                  ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.green.shade400,
                                  shadowColor: Colors.blue.shade400,
                                  elevation: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Casual Leaves'),
                                        SizedBox(height: 10.0,),
                                        Text('4/9')
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LeaveLists())
                                  );
                                }
                            ),
                            InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  color: Colors.yellow.shade400,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Medical Leaves'),
                                        SizedBox(height: 10.0,),
                                        Text('4/9')
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LeaveLists())
                                  );
                                }
                            ),
                            InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  color: Colors.red.shade400,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    height: 100.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Unpaid Leaves'),
                                        SizedBox(height: 10.0,),
                                        Text('4/9')
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LeaveLists())
                                  );
                                }
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        Text('Leave Request Info'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('From'),
                              Text('To'),
                              Text('Status'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provMdl.leavesModel.leaves!.length,
                            //padding: EdgeInsets.all(8.0),
                            itemBuilder: (context,index){
                              var fromDateTime = DateTime.parse(provMdl.leavesModel.leaves![index].fromDate.toString());
                              var fromDateParse = DateFormat("yyyy-MM-dd HH:mm").parse(fromDateTime.toString(), true);
                              print(fromDateParse);
                              String fromDate = DateFormat("dd-MM-yyyy").format(fromDateParse.toLocal()).toString();
                              var toDateTime = DateTime.parse(provMdl.leavesModel.leaves![index].toDate.toString());
                              var toDateParse = DateFormat("yyyy-MM-dd HH:mm").parse(toDateTime.toString(), true);
                              print(fromDateParse);
                              String toDate = DateFormat("dd-MM-yyyy").format(toDateParse.toLocal()).toString();
                              String? status;
                              provMdl.leavesModel.leaves!.forEach((element) {
                                element.leavesStatus!.forEach((elementStatus) {
                                  if(elementStatus.granted == true){
                                    status = 'Approved';
                                  }
                                  else if(elementStatus.rejected == true){
                                    status = 'Rejected';
                                  }
                                  else{
                                    status = 'Pending';
                                  }
                                });
                              });
                             return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(fromDate.toString()),
                                    Text(toDate.toString()),
                                    Text(status.toString(),style: TextStyle(
                                      letterSpacing: 0.5,
                                      color: status == "Pending" ? Colors.orange.shade800 : status == "Approved" ? Colors.green : Colors.red
                                    ),),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  : Expanded(child: Center(child: Text('No Leavses')))
                ],
              );
            }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LeaveAndReportPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );
}
