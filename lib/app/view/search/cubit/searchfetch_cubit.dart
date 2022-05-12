import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'searchfetch_state.dart';

class SearchfetchCubit extends Cubit<SearchfetchState> {
  SearchfetchCubit() : super(SearchfetchInitialState()) {
    _client = RestApi();
  }
  late final RestApi _client;
  late final List<Product> result;

  Future<bool> search(String query) async {
    List<Product> data = [];
    if (kDebugMode) {
      print(query);
    }
    emit(SearchfetchingState());
    data = await _client
        .getSearchSuggestions(query: query.toLowerCase())
        .onError((error, stackTrace) {
      if (kDebugMode) {
        emit(SearchfetchErrorState());
        print(error);
      }
      return [];
    });

    if (kDebugMode) {
      print(data);
    }
    if (data.isNotEmpty) {
      emit(SearchfetchedState());
      result = data;
      return true;
    } else if (state is! SearchfetchErrorState) {
      emit(SearchfetchedNoDataState());
    }
    return false;
  }
}