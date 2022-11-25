
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leave_req_provider.dart';
import 'leave_request.dart';
import 'leaves_actions.dart';
import 'add_new_leaves_request.dart';



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
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child:  DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        indicator: const BoxDecoration(
                          borderRadius:  BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.blue,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),
                        tabs: const [
                          Tab(text: 'Request'),
                          Tab(text: 'Action'),
                        ],
                      ),
                    ),
                    const Expanded(
                      child:   TabBarView(
                        children: [
                           LeaveRequest(),
                          LeavesAction(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddNewLeaveReq(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            ),
          );
      /*    Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNewLeaveReq()));*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.0,
  );
}
