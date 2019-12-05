import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pertani_shop/models/product_category.dart';

  class CategoryApiClient{
    final http.Client httpClient = http.Client();
    final _baseUrl = "http://192.168.100.100:3000/category";

    Future<List<ProductCategory>> fetchCategory() async{

      final url = "$_baseUrl";

      final response = await httpClient.get("$url",headers:{
        'Authorization':"Bearer eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyIiwiaWF0IjoxNTc0OTk3Njg3LCJleHAiOjE1NzYyMDcyODd9.QkZjbRAtBV_avyNqOMkdtAaSM2ra9STgrSFP8rSdRsuC5WGQSsQq0i8oOCkjxwDiHHpj4YfJrDZ_fWJB1xSCdhMABHI9BYcXaPQkif3xsGWYyQX9eBzrjJFxlFKcKJdTSe1XCS0Ij64JT1MRBZDOKmtpYJN9pHj73g0jtffeNjc"
      });
      final List data = jsonDecode(response.body);
      return data.map((e)=>ProductCategory.fromMap(map:e)).toList();
    }
  }