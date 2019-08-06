import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double avgRate;
  final int stock;
  final int price;
  final int sold;
  final String desc;
  final ProductCategory category;
  final List<dynamic> imageList;

  Product(
      {this.id,
      this.name,
      this.avgRate,
      this.stock,
      this.price,
      this.sold,
      this.desc,
      this.category,
      this.imageList})
      : super([id]);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        price: map["price"],
        stock: map["stock"],
        sold: map["sold"],
        avgRate:  (map["avgRate"]).toDouble(),
        category: ProductCategory.fromMap(map["category"]),
        imageList: map["imageList"]);
  }
}
