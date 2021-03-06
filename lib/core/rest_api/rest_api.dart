import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:productview/core/rest_api/rest_url_path.dart';

class RestApi {
  RestApi() {
    client = Dio(
      BaseOptions(
        baseUrl: RestPath.baseUrl,
      ),
    );
    client.options.headers = <String, String>{
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.46 Safari/537.36',
    };
  }
  late Dio client;

  Future<Map<String, dynamic>> getSearchSuggestions(
      {required String query, int limit = 10, int offset = 10}) async {
    final response = await client.get<dynamic>(
      RestPath.searchSuggestions,
      queryParameters: <String, dynamic>{
        'limit': limit,
        'offset': offset,
        'search': query,
      },
    );
    final results =
        response.data['data']['products']['results'] as List<dynamic>;

    final productLen = response.data['data']['products']['count'] as int;
    return {
      'count': productLen,
      'result': results
          .map(
            (e) => ProductItem(
              image: e['image'],
              productName: e['product_name'],
              currentCharge: e['charge']['current_charge'] ?? 0.00,
              discountCharge: e['charge']['discount_charge'] ?? 0.00,
              sellingPrice: e['charge']['selling_price'] ?? 0.00,
              profit: e['charge']['profit'] ?? 0.0,
              slug: e['slug'],
              stock: e['stock'],
            ),
          )
          .toList()
    };
  }

  Future<ProductDetail> getProductDetail({required String slug}) async {
    final response = await client.get<dynamic>(
      RestPath.productDetails + '/$slug',
    );
    if (kDebugMode) {
      print(response.data);
    }
    final results = response.data['data'] as Map<String, dynamic>;
    return ProductDetail(
      images: (results['images'] as List<dynamic>)
          .map((e) => e['image'] as String)
          .toList(),
      image: results['image'],
      productName: results['product_name'],
      currentCharge: results['charge']['current_charge'] ?? 0.00,
      discountCharge: results['charge']['discount_charge'] ?? 0.00,
      sellingPrice: results['charge']['selling_price'] ?? 0.00,
      profit: results['charge']['profit'] ?? 0.0,
      slug: results['slug'],
      brandName: results['brand']['name'],
      seller: results['seller'],
      description: results['description'],
      stock: results['stock'],
      cartquantity: 1,
      isEnable: false,
    );
  }
}
