import 'dart:async';

import '../../../common/constant/app_urls.dart';

import '../../../networking/CustomException.dart';
import 'login_model.dart';

class ClientRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Clients>?> fetchMovieList() async {
    final response = await _helper.get(ApiUrls.listNames);
    return ClientDetails.fromJson(response).clients;
  }
}