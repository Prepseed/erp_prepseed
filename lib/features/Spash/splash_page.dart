import 'dart:async';
import 'package:flutter/material.dart';

import '../../common/constant/color_palate.dart';
import '../Authentication/clients/clients.dart';
import '../Authentication/login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? animation;

  @override
  initState()  {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
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
/*    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var InstituteName = prefs.getString('InstituteName');
    var InstituteLogo = prefs.getString('InstituteLogo');*/

/*     if((InstituteName != null) && (InstituteLogo != null) && (username != null)){
     callProvidersPre();
      callProvidersAfter();
    }
  */
    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()
        )));


        /*((InstituteName == null) || (InstituteLogo == null) || (username == null)) ? prepSeed_login() :
        (username == null || username == '') ? signIn_signUp(clientname: InstituteName,clientlogo: InstituteLogo,) :
        landingScreen()  )));*/
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
                          Image.asset('assets/images/logo.png')
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