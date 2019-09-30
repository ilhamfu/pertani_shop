import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pertani_shop/models/product.dart';

class ProductListApiClient{
  final http.Client httpClient = http.Client();
  final String baseUrl = "https://next.json-generator.com/api/json/get/NJoHZR-7v";

  Future<List<Product>> fetchProduct() async{
    final response =  await httpClient.get(baseUrl);
    final json = jsonDecode(response.body);

    return (json as List).map((e)=>Product.fromMap(e)).toList();
  }
}