part of 'restapi_cubit.dart';

@immutable
abstract class RestapiState {}

class RestapiInitial extends RestapiState {}

class RestapiFetchingSearchState extends RestapiState {}

class RestapiFetchedSearchState extends RestapiState {}
