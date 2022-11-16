import 'package:erp_prepseed/features/Leaves/leave_list.dart';
import 'package:erp_prepseed/features/Leaves/leave_req_provider.dart';
import 'package:erp_prepseed/features/Leaves/leaves_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Container(
              //  padding: EdgeInsets.all(10.0),
                height: 150.0,
                width: 180.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Seelect Date Icon.png"),
                    SizedBox(height: 10.0,),
                    Text('Leave Request')
                  ],
                ),
              ),
            ),
            onTap: () async {
              await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LeaveLists())
              );
            }
          ),
        ),
      ),
    );
  }
}
