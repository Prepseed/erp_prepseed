
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../BottomNavigation/bottom_navigation.dart';




class Dashboard extends StatefulWidget {

  List items;
   Dashboard(this.items);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.white,
          title: Text("Dashboard",style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Stack(
          //alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
                child:  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        mainAxisExtent: 160.0
                    ),
                    itemCount: widget.items.length,
                    itemBuilder: (context, index){
                      return  InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 150.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/Seelect Date Icon.png"),
                                SizedBox(height: 10.0,),
                                Text(widget.items[index]['name'].toString(),textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, widget.items[index]['routes'].toString());
                        },
                      );
                    }
                )

              /*ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 150.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/Seelect Date Icon.png"),
                                      SizedBox(height: 10.0,),
                                      Text('Expenses',textAlign: TextAlign.justify,),
                                      Text('Management',textAlign: TextAlign.justify,)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                *//* await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context) => LeaveLists())
                                          );*//*
                              }
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 150.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/Seelect Date Icon.png"),
                                      SizedBox(height: 10.0,),
                                      Text('Payroll',textAlign: TextAlign.justify,),
                                      Text('Management',textAlign: TextAlign.justify,)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                *//* await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves();
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => LeaveLists())
                                      );*//*
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 150.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/Seelect Date Icon.png"),
                                      SizedBox(height: 10.0,),
                                      Text('File',textAlign: TextAlign.justify,),
                                      Text('Management',textAlign: TextAlign.justify,)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                *//* await Provider.of<LeaveReqProvider>(context,listen: false).getLeaves();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context) => LeaveLists())
                                          );*//*
                              }
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 150.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/Seelect Date Icon.png"),
                                      SizedBox(height: 10.0,),
                                      Text('Employee',textAlign: TextAlign.justify,),
                                      Text('Management',textAlign: TextAlign.justify,)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                       Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Dashboard())
                                      );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),*/
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
