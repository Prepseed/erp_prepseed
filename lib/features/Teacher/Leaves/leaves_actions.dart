import 'package:erp_prepseed/common/functions/functions.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'leave_req_provider.dart';
import 'leaves_model.dart';


class LeavesAction extends StatefulWidget {
  const LeavesAction({Key? key}) : super(key: key);

  @override
  State<LeavesAction> createState() => _LeavesActionState();
}

class _LeavesActionState extends State<LeavesAction> {
  String? role;
  String? userId;
  @override
  void initState() {
    SharedPreferences pref;
    Future.microtask(() async => {
      pref = await SharedPreferences.getInstance(),
      role = pref.getString('Role'),
      userId = pref.getString('userId'),
      await Provider.of<LeaveReqProvider>(context,listen: false).leaves()
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provMdl = Provider.of<LeaveReqProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<LeaveReqProvider>(
          builder: (context,data,_) {
            return provMdl.leavesModel.leaves != null && provMdl.leavesModel.leaves!.isNotEmpty
            ?  ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10.0),
              shrinkWrap: true,
              itemCount: provMdl.leavesModel.leaves!.length,
              itemBuilder: (context,index){
                return  role != 'hr'
                    ? employeeWidget(provMdl.leavesModel.leaves![index])
                    : hrWidget(provMdl.leavesModel.leaves![index]);
              },
            )
            : const Center(child: Text('No Leaves'));
          }
      ),
    );
  }
/*  onTaps(Leaves leaves){
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
                                    children: [
                                      const Text('Date      '),
                                      const Text('Day'),
                                      const Text('Type'),
                                      const Text('Action'),
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
                                                print(date);
                                                await Provider.of<LeaveReqProvider>(context,listen: false).leaveAction(leaves.sId.toString(),date,"grant");
                                                print('grant');
                                              },
                                            )
                                          ],
                                        ),
                                        */
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
  /*
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
    */
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
  /*
  }*/

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const [
                         Text('Date'),
                         Text('Type'),
                         Text('Status'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  listView(leaves.leavesStatus!)
                ],
              ),
           );
  }

  employeeWidget(Leaves leaves){
    List<LeavesStatus> list = leaves.leavesStatus!;
      return userId == leaves.user!.sId
      ? ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Date',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text('Type',style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
                Text('Status',style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
              ],
            ),
          ),
          const SizedBox(height: 15.0,),
          Expanded(
           child: listView(list),
         )
        ],
      ) : Container();
  }
  
  listView(List<LeavesStatus> list){

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context,ind){
        String fromDate = Functions().dateFormatter(list[ind].date.toString());
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                  SizedBox(
                    width: 70.0,
                    child:list[ind].rejected == true ? const Text('Rejected',textAlign: TextAlign.center,style:  TextStyle(color: Colors.red),)
                        : list[ind].granted == true ? const Text('Approved',textAlign: TextAlign.center,style:  TextStyle(color: Colors.green))
                        : const Text('Pending'),
                  )
                ],
              ),
              const SizedBox(height: 10.0,)
            ],
          ),
        );
      },
    );
  }

  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );
}
