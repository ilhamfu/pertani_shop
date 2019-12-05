import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product_category.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int stock;
  final int price;
  final String desc;
  final double avgRate;
  final int sold;
  final int rated;
  final ProductCategory productCategory;
  final List<String> productImages;

  Product(
      {this.id,
      this.name,
      this.stock,
      this.price,
      this.desc,
      this.avgRate,
      this.sold,
      this.rated,
      this.productCategory,
      this.productImages})
      : super([id]);

  factory Product.fromMap({Map<String, dynamic> map}) {
    return Product(
      id: map["id"],
      name: map["name"],
      stock: map["stock"],
      price: map["price"],
      desc: map["desc"],
      avgRate: map["avg_rate"].toDouble(),
      sold: map["sold"],
      rated: map["rated"],
      productCategory: ProductCategory.fromMap(map: map["productCategory"]),
      productImages: map["productImages"].cast<String>(),
    );
  }

  String getThumbnail() {
    if (this.productImages.length > 0) {
      return this.productImages[0];
    } else {
      return "https://picsum.photos/300/400";
    }
  }
}
