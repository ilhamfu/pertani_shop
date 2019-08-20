import 'dart:convert';

import 'package:http/http.dart';
import 'package:pertani_shop/models/product_category.dart';
import 'package:pertani_shop/utils/coded_exception.dart';

class CategoryApiClient {
  final String baseUrl;
  final Client httpClient;

  CategoryApiClient(
      {Client httpClient,
      this.baseUrl = "https://next.json-generator.com/api/json/get/41gf36b7P"})
      : this.httpClient = httpClient ?? Client();

  Future<List<ProductCategory>> fetch() async {
    try {
      final response = await httpClient.get(baseUrl);

      final result = jsonDecode(response.body);
      List<ProductCategory> data = [];

      for (var i in result) {
        data.add(ProductCategory.fromMap(i));
      }
      return data;
    } catch (e) {
      throw CodedException(code: CodedException.PRODUCT_FETCH_ERROR);
    }
  }
}
