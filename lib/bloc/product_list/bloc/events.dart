import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class ProductListEvent extends Equatable {
  ProductListEvent([List props = const []]) : super(props);
}

class ProductListInitialize extends ProductListEvent {}

class ProductListFetch extends ProductListEvent {
  final ProductCategory category;
  final double rating;
  final String name;
  final int maxPrice;
  final int minPrice;

  ProductListFetch(
      {this.category, this.rating, this.name, this.maxPrice, this.minPrice})
      : super([category, rating, name, maxPrice, minPrice]);
}
