import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'restapi_state.dart';

class RestapiCubit extends Cubit<RestapiState> {
  RestapiCubit() : super(RestapiInitial()) {
    _client = RestApi();
  }

  late final RestApi _client;

  void testGet(String query) {
    emit(RestapiFetchingSearchState());
    if (kDebugMode) {
      _client.getSearchSuggestions(query: query).then((value) => print(value));
    }
    emit(RestapiFetchedSearchState());
  }
}
