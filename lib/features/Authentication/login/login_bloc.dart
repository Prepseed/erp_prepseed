/*
import 'dart:async';

import '../../../networking/response.dart';
import 'clients_model.dart';
import 'clients_repository.dart';

class LoginBloc {
  ClientRepository _movieRepository = ClientRepository();

  StreamController<ApiResponse<List<Clients>>> _movieListController = StreamController<ApiResponse<List<Clients>>>();

  StreamSink<ApiResponse<List<Clients>>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<List<Clients>>> get movieListStream =>
      _movieListController.stream;

  LoginBloc() {
    _movieListController = StreamController<ApiResponse<List<Clients>>>();
    _movieRepository = ClientRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching'));
    try {
      List<Clients>? clients = await _movieRepository.fetchMovieList();
      movieListSink.add(ApiResponse.completed(clients));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController.close();
  }
}
*/
