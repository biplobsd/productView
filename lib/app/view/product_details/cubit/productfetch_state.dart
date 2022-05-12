part of 'productfetch_cubit.dart';

@immutable
abstract class ProductfetchState {}

class ProductfetchInitialState extends ProductfetchState {}

class ProductfetchingState extends ProductfetchState {}

class ProductfetchedState extends ProductfetchState {}

class ProducterrorState extends ProductfetchState {}

class ProductfetchedNoDataState extends ProductfetchState {}
