
import 'package:erp_prepseed/features/Teacher/Leaves/leaves_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dashboard.dart';
import 'leave_req_provider.dart';
import 'leaves_request.dart';



class LeaveLists extends StatefulWidget {
  const LeaveLists({Key? key}) : super(key: key);

  @override
  State<LeaveLists> createState() => _LeaveListsState();
}

class _LeaveListsState extends State<LeaveLists> {

  var role;
@override
  void initState() {
  SharedPreferences pref;
  Future.microtask(() async => {
   pref = await SharedPreferences.getInstance(),
    role = pref.getString('Role'),
    await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves(role == 'hr' ? true : false)
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final provMdl = Provider.of<LeaveReqProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
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
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
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
            SizedBox(height: 20.0,),
            Expanded(
              child: role == 'hr'
              ? DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.blue,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                       /* labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),*/
                        tabs: const [
                          Tab(text: 'Request'),
                          Tab(text: 'Action'),
                        ],
                      ),
                    ),
                    Expanded(
                      child:  TabBarView(
                        children: [
                          // allUserTasks(),
                          Request(provMdl),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : provMdl.leavesModel.leaves != null ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('From'),
                        Text('To'),
                        Text('Action'),
                      ],
                    ),
                    SizedBox(height: 5.0,),
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
                          String? subSvg;
                          String? img;
                          if(provMdl.leavesModel.leaves![index].user != null){
                            if(provMdl.leavesModel.leaves![index].user!.dp.toString() != null){
                              subSvg =provMdl.leavesModel.leaves![index].user!.dp.toString();
                              img = subSvg.split('.').last;
                            }
                          }
                          return  role != 'hr'
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(fromDate.toString()),
                              Text(toDate.toString()),
                              Text(status.toString(),style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: status == "Pending" ? Colors.orange.shade800 : status == "Approved" ? Colors.green : Colors.red
                              ),)
                            ],
                          )
                           : Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    subSvg == null ?
                                    Container()
                                        : img!.contains('svg')
                                        ? SvgPicture.network(
                                      provMdl.leavesModel.leaves![index].user!.dp.toString(),
                                      fit: BoxFit.contain,
                                      height: 40.0,
                                    ) : CachedNetworkImage(imageUrl: subSvg,height: 45.0,),
                                    SizedBox(width: 10.0,),
                                    Text( provMdl.leavesModel.leaves![index].user!.name.toString())
                                  ],
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('From'),
                                    Text('To'),
                                    Text('Action'),
                                  ],
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(fromDate.toString()),
                                    Text(toDate.toString()),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(Icons.cancel),
                                          ),
                                          onTap: (){
                                            print('reject');
                                          },
                                        ),
                                        SizedBox(width: 10.0,),
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(Icons.task_alt),
                                          ),
                                          onTap: (){
                                            print('grant');
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ) 
                  : Center(child: CircularProgressIndicator(),),
            ),
          ],
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

  Request(LeaveReqProvider provMdl){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<LeaveReqProvider>(
        builder: (context,data,_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // padding: EdgeInsets.all(10.0),
            children: [
              provMdl.leavesModel.leaves != null && provMdl.leavesModel.leaves!.length != 0
              ? Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0,),
                    Text('Leave Request Info'),
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
                          String? subSvg;
                          String? img;
                          if(provMdl.leavesModel.leaves![index].user != null){
                            if(provMdl.leavesModel.leaves![index].user!.dp.toString() != null){
                              subSvg =provMdl.leavesModel.leaves![index].user!.dp.toString();
                              img = subSvg.split('.').last;
                            }
                          }
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      subSvg == null ?
                                      Container()
                                          : img!.contains('svg')
                                          ? SvgPicture.network(
                                        provMdl.leavesModel.leaves![index].user!.dp.toString(),
                                        fit: BoxFit.contain,
                                        height: 40.0,
                                      ) : CachedNetworkImage(imageUrl: subSvg,height: 45.0,),
                                      SizedBox(width: 10.0,),
                                      Text( provMdl.leavesModel.leaves![index].user!.name.toString())
                                    ],
                                  ),
                                  onTap:(){
                                    List<LeavesStatus> leavesStatus = provMdl.leavesModel.leaves![index].leavesStatus!;
                                    onTaps(provMdl.leavesModel.leaves![index].leavesStatus);
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('From'),
                                    Text('To'),
                                    Text('Action'),
                                  ],
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(fromDate.toString()),
                                    Text(toDate.toString()),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(Icons.cancel),
                                          ),
                                          onTap: (){
                                            print('reject');
                                          },
                                        ),
                                        SizedBox(width: 10.0,),
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(Icons.task_alt),
                                          ),
                                          onTap: (){
                                            print('grant');
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
  );
  }

  onTaps(List<LeavesStatus>? leavesStatus){
    return showDialog(
        context: context,
        builder: (context){
            return Container(

              child: AlertDialog(
                insetPadding: EdgeInsets.zero,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
               //  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date'),
                        Text('Day'),
                        Text('Type'),
                        Text('Action'),
                      ],
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: leavesStatus!.length,
                        itemBuilder: (context,index){
                          var fromDateTime = DateTime.parse(leavesStatus[index].date.toString());
                          var fromDateParse = DateFormat("yyyy-MM-dd HH:mm").parse(fromDateTime.toString(), true);
                          print(fromDateParse);
                          String fromDate = DateFormat("dd-MM-yyyy").format(fromDateParse.toLocal()).toString();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(fromDate.toString(),style: textStyle,),
                                leavesStatus[index].fullDay == true ? Text("Full Day",style: textStyle,) : Text('Half Day',style: textStyle,),
                                Text(leavesStatus[index].type.toString(),style: textStyle,),
                                Expanded(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.cancel),
                                        ),
                                        onTap: (){
                                          print('reject');
                                        },
                                      ),
                                      SizedBox(width: 10.0,),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(Icons.task_alt),
                                        ),
                                        onTap: (){
                                          print('grant');
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
        }
    );
  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );
}
