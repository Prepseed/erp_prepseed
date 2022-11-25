
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/color_palate.dart';
import '../../../common/constant/sharedPref.dart';
import '../../../common/widgets/exceptionHandler_widgets.dart';
import '../../../networking/response.dart';

import '../../Teacher/Leaves/dashboard.dart';
import 'login_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();

  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("This is a Custom Toast"),
      ],
    ),
  );
  List<Map> hr = [{'name' : 'Manage Leaves', 'routes' : '/employeeLeaveList'},
    {'name' : 'Files Management', 'routes' : ''},
    {'name' : 'Payroll Management', 'routes' : ''},
    {'name' : 'Expenses Management', 'routes' : ''}];
  List<Map> mentor = [
    {'name' : 'Add/Request Leaves', 'routes' :'/employeeLeaveList'}, {'name' : 'Attendance Management','routes' : ''}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      controller: _password,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ), onPressed: () { setState(() {
                            _passwordVisible = !_passwordVisible;
                          }); },
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      /*child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),*/
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () async {
                        var bodyData = {
                          "user":
                          {
                            "email": _email.text.toString(),
                            "password": _password.text.toString()
                          },
                          "portal":"preparation"
                        };
                        if(_email.text.isNotEmpty && _password.text.isNotEmpty){
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                            await Provider.of<LoginProvider>(context, listen: false).grantAccess(json.encode(bodyData));
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var role = prefs.getString('Role');
                            print(role);
                            var role1 = await sharedPref().getSharedPref('role');
                            print(role1);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) =>  Dashboard(role == "mentor" ? mentor : role == "hr" ? hr : []),
                            ));
                          });

                        }else{
                          print('Authenticate fails');
                          FToast().showToast(child: toast,
                              toastDuration: Duration(seconds: 2),
                              positionedToastBuilder: (context, child) {
                                return Positioned(
                                  child: child,
                                  top: 16.0,
                                  left: 16.0,
                                );
                              }
                          );
                        }
                      },
                      child: Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: Consumer<LoginProvider>(
                            builder: (_,loginModel,model) {
                              return  Center(
                                child: (!loginModel.isLoading)? Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ): SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30.0,
                              ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                    )
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Powered by',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Prepseed',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
