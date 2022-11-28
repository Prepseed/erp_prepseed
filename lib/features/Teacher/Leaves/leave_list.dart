import 'package:erp_prepseed/features/Teacher/Leaves/leaves_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/functions/functions.dart';
import 'leave_req_provider.dart';
import 'add_new_leaves_request.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class LeaveLists extends StatefulWidget {
  const LeaveLists({Key? key}) : super(key: key);

  @override
  State<LeaveLists> createState() => _LeaveListsState();
}

class _LeaveListsState extends State<LeaveLists> {

  String? role;
  String? userId;
@override
  void initState() {
  SharedPreferences pref;
  Future.microtask(() async => {
   pref = await SharedPreferences.getInstance(),
    role = pref.getString('Role'),
    userId = pref.getString('userId'),
    await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves(role == 'hr' ? true : false),

  });
    super.initState();
  }
  List casualList = [];
  List unPaidList = [];
  List medicalList = [];
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
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                ),
                child: const Icon(Icons.arrow_back_ios_new,size: 15.0,color: Colors.black,),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            role != null ? role != 'hr' ? Consumer<LeaveReqProvider>(
              builder: (context,data,_) {
                if(provMdl.leavesModel.leaves != null ){
                  casualList = [];
                  unPaidList = [];
                  medicalList = [];
                for (var element in provMdl.leavesModel.leaves!) {
                  if(element.user!.sId == userId){
                  for (var elementLeave in element.leavesStatus!) {
                    if(elementLeave.type == "Casual" && elementLeave.granted == true){
                      casualList.add(elementLeave);
                    }
                    else if(elementLeave.type == "Unpaid" && elementLeave.granted == true){
                      unPaidList.add(elementLeave);
                    }
                    else if(elementLeave.type == "Medical" && elementLeave.granted == true){
                      medicalList.add(elementLeave);
                    }
                  }}
                }}
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.green.shade400,
                              shadowColor: Colors.blue.shade400,
                              elevation: 5,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Casual Leaves',textAlign: TextAlign.center),
                                    const SizedBox(height: 10.0,),
                                    Text(casualList.length.toString())
                                  ],
                                ),
                              ),
                            ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              color: Colors.yellow.shade400,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Medical Leaves',textAlign: TextAlign.center),
                                    const SizedBox(height: 10.0,),
                                    Text(medicalList.length.toString())
                                  ],
                                ),
                              ),
                            ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              color: Colors.red.shade400,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Unpaid Leaves',textAlign: TextAlign.center),
                                    const SizedBox(height: 10.0,),
                                    Text(unPaidList.length.toString())
                                  ],
                                ),
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            )
            : Container()
            : Center(child: CircularProgressIndicator(),),
            role != null ? role != 'hr' ? const SizedBox(height: 20.0,) : Container(): Container(),
            Expanded(
              child: Padding(
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
              )
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddNewLeaveReq(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            ),
          );
        },
        child:  Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add,size: 25.0,color: Colors.white,)
        ),
      ),
    );
  }

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
          listView(leaves)
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
          child: listView(leaves),
        )
      ],
    ) : Container();
  }

  listView(Leaves leaves){
    List<LeavesStatus> list = leaves.leavesStatus!;
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
          ),
        );
      },
    );
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

  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );
}
