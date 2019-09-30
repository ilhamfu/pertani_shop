import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/product.dart';

class Cart extends Equatable {
  final int id;
  final Product product;
  final int amount;
  final int total;
  final bool active;

  Cart({this.active = true, this.amount, this.id, this.product})
      : this.total = amount * product.price,
        super([id, active, amount]);

  factory Cart.fromCart(Cart cart,
      {bool active, int amount, int id, int product}) {
    return Cart(
        id: id ?? cart.id,
        product: product ?? cart.product,
        amount: amount ?? cart.amount,
        active: active ?? cart.active);
  }
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
        id: map["id"],
        amount: map["amount"],
        product: Product.fromMap(map["product"]));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "total": total,
      "product": {
        "id": product.id,
        "name": product.name,
        "imageList": product.imageList,
        "price": product.price,
        "stock": product.stock
      }
    };
  }

  @override
  String toString() {
    return "Cart<${product.name}>";
  }
}
