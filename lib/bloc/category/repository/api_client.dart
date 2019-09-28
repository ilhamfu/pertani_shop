import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pertani_shop/models/product_category.dart';

  class CategoryApiClient{
    final http.Client httpClient = http.Client();
    final _baseUrl = "https://next.json-generator.com/api/json/get/41gf36b7P";

    Future<List<ProductCategory>> fetchCategory() async{

      final url = "$_baseUrl";

      final response = await httpClient.get("$url");
      final List data = jsonDecode(response.body);
      return data.map((e)=>ProductCategory.fromMap(e)).toList();
    }
  }