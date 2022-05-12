import 'package:dio/dio.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/rest_url_path.dart';

class RestApi {
  late Dio client;
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

  Future<List<Product>> getSearchSuggestions(
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
    return results
        .map(
          (e) => Product(
            image: e['image'],
            productName: e['product_name'],
            currentCharge: e['charge']['current_charge'] ?? 0.0,
            discountCharge: e['charge']['discount_charge'] ?? 0.0,
            sellingPrice: e['charge']['selling_rice'] ?? 0.0,
            profit: e['charge']['profit'] ?? 0.0,
          ),
        )
        .toList();
  }
}
