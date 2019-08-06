import 'dart:convert';

import 'package:pertani_shop/models/product_category.dart';
import 'package:pertani_shop/models/product.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class ProductStream {
  BehaviorSubject<List<Product>> _product =
      BehaviorSubject<List<Product>>.seeded([
    Product(
        name: "Product 1",
        avgRate: 3,
        category: ProductCategory(id: 1, name: "Test"),
        id: 1,
        imageList: [],
        price: 20000,
        stock: 50)
  ]);
  BehaviorSubject<int> _currentPage = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<bool> _hasNext = BehaviorSubject<bool>.seeded(true);

  Observable<List<Product>> get productStream => _product.stream;

  List<Product> get product => _product.value;
  int get currentPage => _currentPage.value;
  bool get hasNext => _hasNext.value;

  ProductStream() {
    // fetchData();
  }

  refetchData() {
    _hasNext.add(false);
    _currentPage.add(0);
    _product.add([]);
    fetchData();
  }

  fetchData() async {
    http
        .get("http://192.168.42.221/api/products/?page=${currentPage + 1}")
        .then((response) {
    List<Product> data = product + product;

      var result = jsonDecode(response.body);
      for (var i in result["results"]) {
        data.add(Product.fromMap(i));
      }
    
      _hasNext.add(result["page_number"]["next"] == null ? false : true);
      _currentPage.add(result["page_number"]["current"]);
  
    _product.add(data);
    }, onError: (e) {
      _product.addError(e);
    });
  }
}
