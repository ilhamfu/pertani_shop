import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product.dart';

abstract class ProductListState extends Equatable{
  ProductListState([List props = const []]):super(props);
}

class ProductListUninitialized extends ProductListState{
}

class ProductListInitialized extends ProductListState{
  final List<Product> product;

  get length => product.length;
  get empty => product.length==0;

  ProductListInitialized({this.product}):super([product]);
}

class ProductListStatus extends ProductListState{
  final int status;

  static const PRODUCT_LIST_FETCHING = 0;
  static const PRODUCT_LIST_ERROR = 1;

  ProductListStatus({this.status}):super([status]);

}