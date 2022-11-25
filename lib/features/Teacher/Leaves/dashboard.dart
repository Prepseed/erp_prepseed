import 'package:flutter/material.dart';
import '../../BottomNavigation/bottom_navigation.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {

  List items;
   Dashboard(this.items, {Key? key}) : super(key: key);
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
          title: const Text("Dashboard",style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Stack(
          //alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
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
                            padding: const EdgeInsets.all(10.0),
                            height: 150.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/Seelect Date Icon.png"),
                                const SizedBox(height: 10.0,),
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
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
