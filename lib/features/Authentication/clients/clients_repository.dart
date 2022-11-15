import 'dart:async';

import '../../../common/constant/app_urls.dart';

import '../../../networking/CustomException.dart';
import 'clients_model.dart';

class ClientRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Clients>?> fetchClientList() async {
    final response = await _helper.get(ApiUrls.listNames);
    return ClientDetails.fromJson(response).clients;
  }
}