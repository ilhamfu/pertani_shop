import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class FilterState extends Equatable {
  FilterState([List props = const []]) : super(props);
}

class FilterInitialized extends FilterState {
  final ProductCategory category;
  final String search;
  final int star;
  final int maxPrice;
  final int minPrice;
  FilterInitialized(
      {this.star, this.search, this.category, this.minPrice, this.maxPrice})
      : super([category, search, star, maxPrice, minPrice]);

  factory FilterInitialized.fromInitialized(FilterInitialized f,
      {int star,
      String search,
      ProductCategory category,
      int minPrice,
      int maxPrice,
      bool clearCategory = false}) {
    return FilterInitialized(
        category: clearCategory ? null : (category ?? f.category),
        search: search ?? f.search,
        star: star ?? f.star,
        maxPrice: maxPrice ?? f.maxPrice,
        minPrice: minPrice ?? f.minPrice);
  }

  factory FilterInitialized.empty() {
    return FilterInitialized(
      category: null,
      search: null,
      star: null,
      maxPrice: null,
      minPrice: null,
    );
  }
}
