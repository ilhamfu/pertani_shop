import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product.dart';

abstract class ProductState extends Equatable {
  ProductState([List props = const []]) : super(props);
}

class ProductUninitalized extends ProductState {
  @override
  String toString() {
    // TODO: implement toString
    return "Product is unitialized";
  }
}

class ProductInitialized extends ProductState {
  final List<Product> product;

  int get length => product.length;

  ProductInitialized({this.product}) : super([product]);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error) : super([error]);

  @override
  String toString() {
    // TODO: implement toString
    return error;
  }
}
