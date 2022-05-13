import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:productview/core/rest_api/rest_api.dart';

part 'productfetch_state.dart';

class ProductfetchCubit extends Cubit<ProductfetchState> {
  ProductfetchCubit({required this.productItem})
      : super(ProductfetchInitialState()) {
    _client = RestApi();

    fetching(productItem.slug);
  }

  late final RestApi _client;
  final ProductItem productItem;
  late final ProductDetail result;

  Future<bool> fetching(String slug) async {
    ProductDetail data;
    emit(ProductfetchingState());
    data =
        await _client.getProductDetail(slug: slug).onError((error, stackTrace) {
      if (kDebugMode) {
        emit(ProducterrorState());
        print(error);
      }
      return ProductDetail(
        image: productItem.image,
        productName: productItem.productName,
        currentCharge: productItem.currentCharge,
        discountCharge: productItem.discountCharge,
        sellingPrice: productItem.sellingPrice,
        profit: productItem.profit,
        stock: productItem.stock,
        slug: slug,
        description: '',
        brandName: '',
        seller: '',
      );
    });

    if (kDebugMode) {
      print(data);
    }
    if (data.seller.isNotEmpty) {
      emit(ProductfetchedState());
      result = data;
      return true;
    } else if (state is! ProducterrorState) {
      emit(ProductfetchedNoDataState());
      result = data;
    }
    return false;
  }
}
