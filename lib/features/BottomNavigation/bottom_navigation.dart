import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60.0,
      items: const [
        Icon(CupertinoIcons.heart_fill,
            size: 25,
            color: Colors.white),
        Icon(CupertinoIcons.add, size: 25, color: Colors.white),
        Icon(CupertinoIcons.music_albums,
            size: 25,
            color: Colors.white),
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
