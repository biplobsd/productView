import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productview/app/view/product_details/product_details.dart';
import 'package:productview/app/view/search/search.dart';
import 'package:productview/app/view/search/widgets/cubit/cartquantitycounter_cubit.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class Routes {
  var cartquantitycounterCubit = CartquantitycounterCubit();
  Route? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SearchPage.pathName:
        return MaterialPageRoute<SearchPage>(
          builder: (context) => BlocProvider.value(
            value: cartquantitycounterCubit,
            child: SearchPage(
              query: args is String ? args : '',
            ),
          ),
        );
      case ProductDetailsPage.pathName:
        return MaterialPageRoute<ProductDetailsPage>(
          builder: (context) => BlocProvider.value(
            value: cartquantitycounterCubit,
            child: ProductDetailsPage(productItem: args as ProductItem),
          ),
        );
      default:
        return null;
    }
  }
}
