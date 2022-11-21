import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../Authentication/login/login.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60.0,
      items:  [
        Icon(CupertinoIcons.heart_fill,
            size: 25,
            color: Colors.white),
        Icon(CupertinoIcons.add, size: 25, color: Colors.white),
        IconButton(onPressed: (){
          logout(context);
        },icon: Icon(Icons.logout)),
      ],
      color: Colors.blueAccent,
      buttonBackgroundColor:  Colors.blueAccent,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeOut,
      animationDuration: const Duration(milliseconds: 400),
      onTap: (index) {
       /* setState(() {
          *//*  _pageIndex = index;*//*
        });*/
      },
      letIndexChange: (index) => true,
    );
  }
}

logout(BuildContext context) {
  Future.delayed(Duration.zero, () async {
    return showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text('Are you Sure?',style: GoogleFonts.poppins(color: Colors.black,),),
                  Divider(color: Colors.black,thickness: 1,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(0.0),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                backgroundColor:  MaterialStateProperty.all<Color>(Colors.transparent)),
                            onPressed: () { Navigator.of(context).pop(); },
                            child: const Text('Cancel')),
                        VerticalDivider(color: Colors.black,thickness: 1,),
                        ElevatedButton(onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          await prefs.clear();
                          /*setState(() {
                          currentItem = MenuItems.home;
                        });*/

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()
                          ));
                        },
                            style: ButtonStyle(elevation: MaterialStateProperty.all<double>(0.0),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                backgroundColor:  MaterialStateProperty.all<Color>(Colors.transparent)),
                            child: const Text('Yes'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  });
}
