import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  Future<void> getSearchSuggestions() async {
    final response = await client.get<dynamic>(
      RestPath.searchSuggestions,
      queryParameters: <String, dynamic>{
        'limit': 1,
        'offset': 1,
        'search': 'rice',
      },
    );

    if (kDebugMode) {
      print(response.data);
    }
  }
}
