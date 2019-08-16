import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product.dart';

abstract class ProductState extends Equatable {
  ProductState([List props = const []]) : super(props);
}

class ProductUninitalized extends ProductState {
  @override
  String toString() {
    return "Product is unitialized";
  }
}

class ProductInitialized extends ProductState {
  final List<Product> products;

  int get length => products.length;
  bool get isEmpty => products.length<=0;
  ProductInitialized({this.products}) : super([products]);
}
class ProductFetching extends ProductState{
  @override
  String toString() {
    return "Product Fetching";
  }
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error) : super([error]);

  @override
  String toString() {
    return error;
  }
}
