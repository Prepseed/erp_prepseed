import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_prepseed/features/Teacher/Leaves/leaves_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../common/functions/functions.dart';
import 'leave_req_provider.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {

  String? role;
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
                  provMdl.leavesModelRequest.leaves != null && provMdl.leavesModelRequest.leaves!.isNotEmpty
                  ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15.0,),
                        role != 'hr' ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:const [
                             Text('From'),
                             Text('To'),
                             Text('Action'),
                          ],
                        ): Container(),
                        role != 'hr' ? const SizedBox(height: 15.0,) : Container(),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provMdl.leavesModelRequest.leaves!.length,
                            //padding: EdgeInsets.all(8.0),
                            itemBuilder: (context,index){
                              return role != 'hr'
                              ? employeeWidget(provMdl.leavesModelRequest.leaves![index])
                              : hrWidget(provMdl.leavesModelRequest.leaves![index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                      : const Expanded(child:  Center(child:  Text('No Leaves')))
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
      subSvg = user.dp.toString();
      img = subSvg.split('.').last;

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
                            padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                            color: Colors.white,
                            child: ListView(
                              shrinkWrap: true,
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      const SizedBox(width: 10.0,),
                                      Text(user.name.toString())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
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

                                    String fromDate = DateFormat("dd-MM-yyyy").format(fromDateParse.toLocal()).toString();
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(fromDate.toString(),style: textStyle,),
                                        leavesStatus[index].fullDay == true ? Text("Full Day",style: textStyle,) : Text('Half Day',style: textStyle,),
                                        Text(leavesStatus[index].type.toString(),style: textStyle,),
                                        leavesStatus[index].granted == true
                                            ? const Text('Approved')
                                            :  leavesStatus[index].rejected == true
                                            ? const Text('Rejected')
                                            :  Row(
                                          children: [
                                            InkWell(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(Icons.cancel),
                                              ),
                                              onTap: () async {
                                                var date = DateFormat("MM-dd-yyyy").format(fromDateParse.toLocal()).toString();
                                                await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leaves.sId.toString(),date,"reject");
                                              },
                                            ),
                                            const SizedBox(width: 10.0,),
                                            InkWell(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(Icons.task_alt),
                                              ),
                                              onTap: () async{
                                                var date = DateFormat("MM-dd-yyyy").format(fromDateParse.toLocal()).toString();
                                                await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leaves.sId.toString(),date,"grant");
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
  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );

  hrWidget(Leaves leaves){
    String? subSvg;
    String? img;
    if(leaves.user != null){
      if(leaves.user!.dp != null){
        subSvg =leaves.user!.dp.toString();
        img = subSvg.split('.').last;
      }
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all( Radius.circular(10.0)),
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
                  leaves.user!.dp.toString(),
                  fit: BoxFit.contain,
                  height: 40.0,
                ) : CachedNetworkImage(imageUrl: subSvg,height: 45.0,),
                const SizedBox(width: 10.0,),
                Text( leaves.user!.name.toString())
              ],
            ),
            onTap:(){
              /*  onTaps(leaves);*/
            },
          ),
          const SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:const [
              Text('Date'),
              Text('Type'),
              Text('Action'),
            ],
          ),
          const SizedBox(height: 10.0,),
          listView(leaves)
        ],
      ),
    );
  }

  listView(Leaves leaves){
    List<LeavesStatus> list = leaves.leavesStatus!;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context,ind){
        String fromDate = Functions().dateFormatter(list[ind].date.toString());

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                SizedBox(
                    width: 100.0,
                    child: Text(fromDate.toString(),style: const TextStyle(
                        letterSpacing: 1.0
                    ),)),
                SizedBox(
                    width: 90.0,
                    child: Text(list[ind].type.toString(),style: const TextStyle(
                        letterSpacing: 1.0
                    ))),
                role != 'hr' ? SizedBox(
                  width: 60.0,
                  child:list[ind].rejected == true ? const Text('Rejected',style:  TextStyle(color: Colors.red),)
                      : list[ind].granted == true ? const Text('Approved',style:  TextStyle(color: Colors.green))
                      :  Text('Pending',style: TextStyle(color: Colors.orange.shade800),),
                ) : list[ind].rejected == true ? const Text('Rejected',style:  TextStyle(color: Colors.red),)
                  : list[ind].granted == true ? const Text('Approved',style:  TextStyle(color: Colors.green))
                  :  Row(
                      children: [
                        InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.cancel),
                          ),
                          onTap: (){
                            alertDialog(leaves.sId.toString(),list[ind].date.toString(),'Reject');
                          },
                        ),
                        const SizedBox(width: 10.0,),
                        InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.task_alt),
                          ),
                          onTap: () async {
                            alertDialog(leaves.sId.toString(),list[ind].date.toString(),'Approve');
                          },
                        )
                     ],
                   ),
              ],
            ),
            const SizedBox(height: 10.0,)
          ],
        );
      },
    );
  }

  employeeWidget(Leaves leaves){
      return listView(leaves);
  }

  alertDialog(String id, String date, String action){
    return showDialog(
        context: context,
        builder: (cnt){
          var fromDateTime = DateTime.parse(date.toString());
          var fromDateParse = DateFormat("yyyy-MM-dd HH:mm").parse(fromDateTime.toString(), true);
          var datesFor = DateFormat("dd-MMM-yyyy").format(fromDateParse.toLocal()).toString();
          var dates = DateFormat("MM-dd-yyyy").format(fromDateParse.toLocal()).toString();
          return AlertDialog(
            elevation: 5.0,
            shape: const RoundedRectangleBorder(
                borderRadius:  BorderRadius.all(Radius.circular(10.0))),

            title: Column(
              children: [
                Text('Are you sure to $action leave on \n$datesFor ?',style: const TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  fontWeight: FontWeight.normal
                ),textAlign: TextAlign.center),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  InkWell(
                      onTap:  () async {
                          action == 'Approve' ? await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(id.toString(),date,"grant")
                         : await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(id.toString(),date,"reject");
                          Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue,),
                            borderRadius: const BorderRadius.all( Radius.circular(10.0))
                        ),
                        margin: const EdgeInsets.only(right: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(action.toUpperCase().toString(),style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold
                        ),),
                      )
                  ),
                  InkWell(
                      onTap:  () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue,),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Cancel'.toUpperCase(),style: const TextStyle(
                            fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        ),),
                      )
                  )
                ],
              )
            ],
          );
        }
    );
  }
}
