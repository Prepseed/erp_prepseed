import 'dart:async';
import 'package:erp_prepseed/features/Leaves/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/color_palate.dart';
import '../../common/constant/sharedPref.dart';
import '../Authentication/clients/clients.dart';
import '../Authentication/login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? animation;
  String? userId;
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
      setState(() {
        userId = userId;
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




/*     if((InstituteName != null) && (InstituteLogo != null) && (username != null)){
     callProvidersPre();
      callProvidersAfter();
    }
  */
    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>
        (userId == null || userId == '') ? LoginScreen() :
        Dashboard() )));
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