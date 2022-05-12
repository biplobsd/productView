import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'restapi_state.dart';

class RestapiCubit extends Cubit<RestapiState> {
  RestapiCubit() : super(RestapiInitial()) {
    _client = RestApi();
  }

  late final RestApi _client;

  // Future<List<ProductItem>> search(String query) async {
  //   emit(RestapiFetchingSearchState());
  //   var data = await _client.getSearchSuggestions(query: query);
  //   emit(RestapiFetchedSearchState());
  //   return data;
  // }
}
