import 'package:flutter/material.dart';
import 'package:productview/app/view/product_details/product_details.dart';
import 'package:productview/app/view/search/search.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class Routes {
  Route? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SearchPage.pathName:
        return MaterialPageRoute<SearchPage>(
          builder: (context) => const SearchPage(),
        );
      case ProductDetailsPage.pathName:
        return MaterialPageRoute<ProductDetailsPage>(
          builder: (context) => ProductDetailsPage(slug: args as ProductItem),
        );
      default:
        return null;
    }
  }
}
