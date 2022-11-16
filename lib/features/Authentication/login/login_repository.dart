import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/app_urls.dart';

import '../../../common/constant/sharedPref.dart';
import '../../../networking/CustomException.dart';
import 'login_model.dart';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignInUser?> fetchClientList(body) async {

    final response = await _helper.post(ApiUrls.signIn, body,true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',response["token"]);
    await prefs.setString('userId',response['user']["_id"]);
    return SignInUser.fromJson(response['user']);
  }
}