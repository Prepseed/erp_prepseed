import 'package:erp_prepseed/features/Leaves/dashboard.dart';
import 'package:erp_prepseed/features/Leaves/leaves_request.dart';
import 'package:flutter/material.dart';

class LeaveLists extends StatefulWidget {
  const LeaveLists({Key? key}) : super(key: key);

  @override
  State<LeaveLists> createState() => _LeaveListsState();
}

class _LeaveListsState extends State<LeaveLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           // padding: EdgeInsets.all(10.0),
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Icon(Icons.arrow_back_ios_new,size: 15.0,color: Colors.black,),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Dashboard())
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Casual Leaves'),
                              SizedBox(height: 10.0,),
                              Text('4/9')
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LeaveLists())
                        );
                      }
                  ),
                  InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Medical Leaves'),
                              SizedBox(height: 10.0,),
                              Text('4/9')
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LeaveLists())
                        );
                      }
                  ),
                  InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          height: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Unpaid Leaves'),
                              SizedBox(height: 10.0,),
                              Text('4/9')
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LeaveLists())
                        );
                      }
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Text('Leave Request Info'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('From'),
                    Text('To'),
                    Text('Status'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  //padding: EdgeInsets.all(8.0),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('19 Apr, 2021'),
                          Text('22 Apr, 2021'),
                          Text('Approved'),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LeaveAndReportPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextStyle textStyle = TextStyle(
    color: Colors.blueGrey,
    fontSize: 10.0,
  );
}
