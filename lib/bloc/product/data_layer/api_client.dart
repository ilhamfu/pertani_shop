import 'dart:convert';

import 'package:http/http.dart';
import 'package:pertani_shop/models/product.dart';

class ProductApiClient {
  final Client httpClient;
  final String baseUrl;

  ProductApiClient(
      {Client httpClient,
      this.baseUrl = "https://next.json-generator.com/api/json/get/NJoHZR-7v"})
      : this.httpClient = httpClient ?? Client();

  Future<List<Product>> fetchData() async {
    List<Product> list = [];
    try {
      final response = await httpClient.get(baseUrl);
      final rawData = jsonDecode(response.body);
      print("length of rawdata : ${rawData.length}");
      for (Map<String, dynamic> i in rawData) {
        list.add(Product.fromMap(i));
      }
    } catch (e) {
      print(e);
    }

    print(list);
    return list;
  }
}
