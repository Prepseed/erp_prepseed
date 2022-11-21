import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_prepseed/features/Teacher/Leaves/leaves_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'leave_req_provider.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {

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
      body: Padding(
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
                        role != 'hr' ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('From'),
                            Text('To'),
                            Text('Action'),
                          ],
                        ): Container(),
                        role != 'hr' ? SizedBox(height: 15.0,) : Container(),
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
                              return role != 'hr'
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
                                      /*  List<LeavesStatus> leavesStatus = provMdl.leavesModel.leaves![index].leavesStatus!;
                                        onTaps(provMdl.leavesModel.leaves![index]);*/
                                        onTaps(provMdl.leavesModel.leaves![index]);
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
      ),
    );
  }
  onTaps(Leaves leaves){
    List<LeavesStatus>? leavesStatus = leaves.leavesStatus;
    User user = leaves.user!;
    String? subSvg;
    String? img;
    if(user.dp.toString() != null){
      subSvg = user.dp.toString();
      img = subSvg.split('.').last;
    }
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              child: StatefulBuilder(
                  builder: (context,setState) {
                    return Consumer(
                        builder: (context,data,_) {
                          return Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: MediaQuery.of(context).size.height -  80,
                            padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                            color: Colors.white,
                            child: ListView(
                              shrinkWrap: true,
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      subSvg == null ?
                                      Container()
                                          : img!.contains('svg')
                                          ? SvgPicture.network(
                                        user.dp.toString(),
                                        fit: BoxFit.contain,
                                        height: 40.0,
                                      ) : CachedNetworkImage(imageUrl: subSvg,height: 45.0,),
                                      SizedBox(width: 10.0,),
                                      Text(user.name.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date      '),
                                      Text('Day'),
                                      Text('Type'),
                                      Text('Action'),
                                    ],
                                  ),
                                ),
                                ListView.builder(
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
                                        leavesStatus[index].granted == true
                                            ? Text('Approved')
                                            :  leavesStatus[index].rejected == true
                                            ? Text('Rejected')
                                            :  Row(
                                          children: [
                                            InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle
                                                ),
                                                child: Icon(Icons.cancel),
                                              ),
                                              onTap: () async {
                                                var date = DateFormat("MM-dd-yyyy").format(fromDateParse.toLocal()).toString();
                                                print(date);
                                                await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leaves.sId.toString(),date,"reject");
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
                                              onTap: () async{
                                                var date = DateFormat("MM-dd-yyyy").format(fromDateParse.toLocal()).toString();
                                                print(date);
                                                await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leaves.sId.toString(),date,"grant");
                                                print('grant');
                                              },
                                            )
                                          ],
                                        ),
                                        /*  leavesStatus[index].granted == false && leavesStatus[index].rejected == false
                                    ? Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(Icons.cancel),
                                          ),
                                          onTap: () async {
                                            await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leavesStatus[index].sId.toString(),"reject");
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
                                    )
                                    : Container(),
                                    leavesStatus[index].granted == true  ? Text('Approved') : Container(),
                                    leavesStatus[index].rejected == true ? Text('Rejected') : Container()*/
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        }
                    );
                  }
              ),
            ),
          );
        });
    /*showDialog(
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
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
        }
    );*/
  }
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );
}
