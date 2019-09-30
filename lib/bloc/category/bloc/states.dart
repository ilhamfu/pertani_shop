import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryUninitialized extends CategoryState {}

class CategoryInitialized extends CategoryState {
  final List<ProductCategory> category;

  get length => category.length;
  get isEmpty => category.length == 0;

  CategoryInitialized({this.category}) : super([category]);
}

class CategoryStatus extends CategoryState {
  final int status;

  static const int CATEGORY_FETCHING = 0;
  static const int CATEGORY_ERROR = 1;

  CategoryStatus({this.status});
}
