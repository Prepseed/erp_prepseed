
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/../../common/constant/app_urls.dart';
import '/../../common/constant/sharedPref.dart';
import '/../../networking/CustomException.dart';
import 'leaves_model.dart';

class LeaveReqProvider extends ChangeNotifier{
  ApiBaseHelper _helper = ApiBaseHelper();
  String? userId;
  LeavesModel leavesModel = LeavesModel();
  LeavesModel leavesModelRequest = LeavesModel();
  getLeaves(bool hr) async{
    userId = await sharedPref().getSharedPref('userId');
    String url = hr ? "https://napi.prepseed.com/leaves/request" : "https://napi.prepseed.com/leaves/request?id=$userId";
    final response = await _helper.get(url);
    leavesModelRequest = LeavesModel.fromJson(response);
    print(leavesModelRequest);
    leaves();
    notifyListeners();
  }

  leaves() async{
    userId = await sharedPref().getSharedPref('userId');
    String url = "https://napi.prepseed.com/leaves?format=user&startDate=11/21/2022&endDate=12/31/2022";
    final response = await _helper.get(url);
    leavesModel = LeavesModel.fromJson(response);
    print(leavesModel);
    notifyListeners();
  }


  String? msg;
  leaveReq(body) async {
      final response = await _helper.post("https://napi.prepseed.com/leaves/request", body);
      msg = response["msg"];
      SharedPreferences pref = await SharedPreferences.getInstance();
      var role = pref.getString('Role');
      getLeaves(role == 'hr' ? true : false);
      print(msg);
      notifyListeners();
  }

  leaveAction(String id, String date, String action) async {
    final response = await _helper.put("https://napi.prepseed.com/leaves/request?leaveId=$id&date=$date&action=$action");
    print(response);
    getLeaves(true);
    notifyListeners();
  }
}