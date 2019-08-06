import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

abstract class FilterEvent extends Equatable{
  FilterEvent([List props = const []]):super(props);
}

class FetchFilter extends FilterEvent{
  @override
  String toString() {
    return "Fetching Filter";
  }
}

class UpdatePrice extends FilterEvent{
  final int max;
  final int min;

  UpdatePrice({this.max=-1,this.min=-1}):super([max,min]);

  @override
  String toString() {
    return "Update price filter to : {max:$max,min:$min}";
  }
}

class UpdateCategory extends FilterEvent{
  final ProductCategory category;

  UpdateCategory({this.category}):super([category]);

  @override
  String toString() {
    return "Update category filter to : {id:${category.id},name:${category.name}}";
  }
}

class UpdateStar extends FilterEvent{
  final int star;
  UpdateStar({this.star=0}):super([star]);
  @override
  String toString() {
    return "Update category filter to : $star";
  }
}

class UpdateSearch extends FilterEvent{
  final String term;
  UpdateSearch({this.term=""}):super([term]);

  @override
  String toString() {
    return "Update searc filter to : $term";
  }
}