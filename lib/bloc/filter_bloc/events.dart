import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pertani_shop/models/product_category.dart';

class FilterEvent extends Equatable {
  FilterEvent([List props = const []]) : super(props);
}

class FilterInit extends FilterEvent{}

class FilterSetPrice extends FilterEvent{
  final int maxPrice;
  final int minPrice;
  FilterSetPrice({@required this.maxPrice, @required this.minPrice}):super([maxPrice,minPrice]);
}

class FilterSetCategory extends FilterEvent{
  final ProductCategory productCategory;
  final bool clearCategory;
  FilterSetCategory({@required this.productCategory,this.clearCategory=false}):super([productCategory,clearCategory]);
}

class FilterSetSearch extends FilterEvent{
  final String search;

  FilterSetSearch({@required this.search}) : super([search]);
}

class FilterSetStar extends FilterEvent{
  final int star;

  FilterSetStar({@required this.star}) : super([star]);
}

class FilterClear extends FilterEvent{}