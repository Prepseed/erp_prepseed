import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/color_palate.dart';
import '../../common/constant/sharedPref.dart';
import '../Authentication/clients/clients.dart';
import '../Authentication/login/login.dart';
import '../Teacher/Leaves/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? animation;
  String? userId;
  var role;
  @override
  initState()  {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
      role = prefs.getString('Role');
      setState(() {
        userId = userId;
        role = role;
      });
    });
    timer();
  }

/*  callProvidersPre() async{
    await InitProviders().initProvider();
  }

  callProvidersAfter(){
    InitProviders().initProviderAfter();
  }*/

  dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void> timer() async {

    List<Map> hr = [{'name' : 'Manage Leaves', 'routes' : '/employeeLeaveList'},
      {'name' : 'Files Management', 'routes' : ''},
      {'name' : 'Payroll Management', 'routes' : ''},
      {'name' : 'Expenses Management', 'routes' : ''}];
    List<Map> mentor = [
      {'name' : 'Add/Request Leaves', 'routes' :'/employeeLeaveList'}, {'name' : 'Attendance Management','routes' : ''}
    ];


/*     if((InstituteName != null) && (InstituteLogo != null) && (username != null)){
     callProvidersPre();
      callProvidersAfter();
    }
  */
    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>
        (userId == null || userId == '') ? LoginScreen() :
        Dashboard(role == "mentor" ? mentor : role == "hr" ? hr : []) )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        // color: Constants.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                    scale: animation!,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Image.asset('assets/images/logo.png',height: 60.0,)
                        ]
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}