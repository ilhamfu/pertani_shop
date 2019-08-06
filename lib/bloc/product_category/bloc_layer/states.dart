import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryUninitialized extends CategoryState {
  @override
  String toString() {
    return "Category Uninitialized";
  }
}

class CategoryError extends CategoryState {
  @override
  String toString() {
    return "Category Error";
  }
}

class CategoryInitialized extends CategoryState {
  final List<ProductCategory> category;

  CategoryInitialized({this.category}) : super([category]);

  CategoryInitialized copyFrom({List<ProductCategory> category}) {
    return CategoryInitialized(category: category ?? this.category);
  }

  @override
  String toString() {
    return "Category initialized";
  }
}
