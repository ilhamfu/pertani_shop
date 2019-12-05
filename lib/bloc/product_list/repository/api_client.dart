import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pertani_shop/models/product.dart';

class ProductListApiClient {
  final http.Client httpClient = http.Client();
  final String baseUrl = "http://192.168.100.100:3000/product";

  Future<List<Product>> fetchProduct() async {
    try {
      final response = await httpClient.get(baseUrl, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyIiwiaWF0IjoxNTc0OTk3Njg3LCJleHAiOjE1NzYyMDcyODd9.QkZjbRAtBV_avyNqOMkdtAaSM2ra9STgrSFP8rSdRsuC5WGQSsQq0i8oOCkjxwDiHHpj4YfJrDZ_fWJB1xSCdhMABHI9BYcXaPQkif3xsGWYyQX9eBzrjJFxlFKcKJdTSe1XCS0Ij64JT1MRBZDOKmtpYJN9pHj73g0jtffeNjc"
      });
      final json = jsonDecode(response.body);
      final productList =
          (json["data"] as List).map((e) => Product.fromMap(map: e)).toList();
      return productList;
    } catch (error) {
      throw error;
    }
  }
}
