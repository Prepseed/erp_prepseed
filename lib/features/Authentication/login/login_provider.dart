import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';

import '../../../networking/app_exception.dart';
import 'login_model.dart';
import 'login_repository.dart';


class LoginProvider extends ChangeNotifier{
  final _loginRepository = LoginRepository();
  bool isLoading = false;
  SignInUser _user = SignInUser();
  SignInUser get clients => _user;


  Future<void> grantAccess(body) async {
    isLoading = true;
    notifyListeners();

    final response = await _loginRepository.fetchClientList(body);

    _user = response!;
    isLoading = false;
    notifyListeners();
  }
}


class ApiProvider {

  Future<dynamic> post(String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),

      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}