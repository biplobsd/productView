import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'restapi_state.dart';

class RestapiCubit extends Cubit<RestapiState> {
  RestapiCubit() : super(RestapiInitial()) {
    _client = RestApi();
  }

  late final RestApi _client;

  void testGet() {
    emit(RestapiFetchingSearchState());
    _client.getSearchSuggestions();
    emit(RestapiFetchedSearchState());
  }
}
