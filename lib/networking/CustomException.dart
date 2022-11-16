import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../common/constant/sharedPref.dart';
import 'app_exception.dart';

class ApiBaseHelper {

  Future<dynamic> get(String url) async {
    var token =  await sharedPref().getSharedPref('token');
    print('Api Get, url $url');
    var headers =   {
      'Content-type' : 'application/json',
      'authorization': 'Bearer $token',
    };
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, [bool auth = false]) async {
    var token = auth ? null : await sharedPref().getSharedPref('token');
    print('Api Post, url $url');
    var responseJson;
    var headers = auth ? {
      'Content-type' : 'application/json',
    } : {
      'Content-type' : 'application/json',
    'authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers,
          body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

/*  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }*/
}

dynamic _returnResponse(http.Response response) {
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