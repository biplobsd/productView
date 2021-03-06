import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'searchfetch_state.dart';

class SearchfetchCubit extends Cubit<SearchfetchState> {
  SearchfetchCubit({required this.query}) : super(SearchfetchInitialState()) {
    _client = RestApi();

    search(query, addList: false);
  }
  late String query;
  late final RestApi _client;
  late int count;

  late List<ProductItem> result = [];
  late int offset = 10;

  Future<bool> search(
    String query, {
    int offset = 10,
    bool addList = true,
  }) async {
    this.query = query;
    if (!addList) {
      emit(SearchfetchInitialState());
      result = [];
    }
    this.offset = offset;

    var data = <ProductItem>[];
    if (kDebugMode) {
      print(query);
      print(addList);
      print('Size of result: ${result.length}');
    }
    emit(SearchfetchingState());
    final rawdata = await _client
        .getSearchSuggestions(query: query.toLowerCase(), offset: offset)
        .onError((error, stackTrace) {
      if (kDebugMode) {
        emit(SearchfetchErrorState());
        this.offset = 10;
        print(error);
      }
      return {
        'result': [],
        'count': 0,
      };
    });
    data = rawdata['result'] as List<ProductItem>;
    count = rawdata['count'] as int;
    if (kDebugMode) {
      print(count);
    }

    if (data.isNotEmpty) {
      emit(SearchfetchedState());
      result += data;
      return true;
    } else if (state is! SearchfetchErrorState) {
      emit(SearchfetchedNoDataState());
      this.offset = 10;
    }
    return false;
  }
}
