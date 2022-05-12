part of 'searchfetch_cubit.dart';

@immutable
abstract class SearchfetchState {}

class SearchfetchInitialState extends SearchfetchState {}

class SearchfetchingState extends SearchfetchState {}

class SearchfetchedState extends SearchfetchState {}

class SearchfetchedNoDataState extends SearchfetchState {}

class SearchfetchErrorState extends SearchfetchState {}
