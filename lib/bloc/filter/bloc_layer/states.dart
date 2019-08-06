import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class FilterState extends Equatable {
  FilterState([List props = const []]) : super(props);
}

class FilterSet extends FilterState {
  final ProductCategory productCategory;
  final int star;
  final String search;
  final Map<String, dynamic> price;

  FilterSet(
      {this.productCategory,
      this.star = 0,
      this.search = "",
      this.price = const {'max': -1, 'min': -1}})
      : super([productCategory, star, search, price]);

  factory FilterSet.copyFrom(FilterSet obj,
      {ProductCategory productCategory,
      int star,
      String search,
      Map<String, dynamic> price}) {
    return FilterSet(
        search: search ?? obj.search,
        star: star ?? obj.star,
        productCategory: productCategory ?? obj.productCategory,
        price: price ?? obj.price);
  }

  Map<String, dynamic> toMap() => {
        "search": this.search,
        "star": this.star,
        "productCategory": this.productCategory,
        "price": this.price
      };

  @override
  String toString() {
    return "Category initialized";
  }
}
