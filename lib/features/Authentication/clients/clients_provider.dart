import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';

import '../../../networking/app_exception.dart';
import 'clients_model.dart';
import 'clients_repository.dart';


class ClientsProvider extends ChangeNotifier{
  final _loginRepository = ClientRepository();
  bool isLoading = false;
  List<Clients> _clients = [];
  List<Clients> get clients => _clients;


  Future<void> getAllClients() async {
    isLoading = true;
    notifyListeners();

    final response = await _loginRepository.fetchClientList();

    _clients = response!;
    isLoading = false;
    notifyListeners();
  }
}


class ApiProvider {
  final String _baseUrl = "https://api.chucknorris.io/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
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