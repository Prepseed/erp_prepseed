
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/constant/app_urls.dart';
import '../../common/constant/sharedPref.dart';
import '../../networking/CustomException.dart';
import 'leaves_model.dart';

class LeaveReqProvider extends ChangeNotifier{
  ApiBaseHelper _helper = ApiBaseHelper();
  String? userId;
  LeavesModel leavesModel = LeavesModel();
  getLeaves() async{
    userId = await sharedPref().getSharedPref('userId');
    String url = "http://192.168.29.183:4040/api/leaves/request?id=$userId";
    final response = await _helper.get(url);
    leavesModel = LeavesModel.fromJson(response);
    print(leavesModel);
    notifyListeners();
  }

  String? msg;
  leaveReq(body) async {
      final response = await _helper.post("http://192.168.29.183:4040/api/leaves/request", body);
      msg = response["msg"];
      getLeaves();
      print(msg);
      notifyListeners();
  }
}