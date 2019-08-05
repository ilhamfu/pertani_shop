import 'dart:convert';

import 'package:pertani_shop/models/product_category.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductCategoryStream {
  BehaviorSubject _category = BehaviorSubject<List<ProductCategory>>.seeded([]);
  BehaviorSubject _isLoaded = BehaviorSubject<bool>.seeded(false);

  Observable get dataStream$ => _category.stream;
  Observable get isLoadedStream$ => _isLoaded.stream;

  bool get data => _category.value;
  bool get isLoaded => _isLoaded.value;

  requestCategory() {
    print("Requesting category data");
    List<ProductCategory> _data = [];
    http.get("http://192.168.42.221/api/categorys/").then((response) {
      if (response.statusCode == 200) {
        for (var i in jsonDecode(response.body)){
          _data.add(ProductCategory.fromMap(i));
        };
        _category.add(_data);
        _isLoaded.add(true);
      }
    });
  }
}
