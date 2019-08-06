import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final int id;
  final String name;

  ProductCategory({this.id, this.name}) : super([id]);

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(id: map["id"], name: map["name"]);
  }
}
