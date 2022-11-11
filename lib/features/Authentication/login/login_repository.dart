import 'dart:async';

import '../../../common/constant/app_urls.dart';

import '../../../networking/CustomException.dart';
import 'login_model.dart';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignInUser?> fetchClientList(body) async {
    final response = await _helper.post(ApiUrls.signIn, body);
    return SignInUser.fromJson(response['user']);
  }
}