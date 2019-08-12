import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartEvent extends Equatable {
  CartEvent([List props = const []]) : super(props);
}

class FetchCart extends CartEvent {
  final bool initialFetch;

  FetchCart({this.initialFetch = true}) : super([initialFetch]);
  @override
  String toString() {
    return "Fetching cart";
  }
}

class CartDelete extends CartEvent {
  final Cart cart;

  CartDelete({this.cart}) : super([cart]);

  @override
  String toString() {
    return "Deleting cart : ${cart.id}";
  }
}

class CartUpdateAmount extends CartEvent {
  final Cart cart;
  final int amount;
  CartUpdateAmount({this.amount, this.cart}) : super([cart, amount]);

  @override
  String toString() {
    return "Fetching cart : ${cart.id}";
  }
}

class CartCreate extends CartEvent {
  final Cart cart;
  final int amount;
  CartCreate({this.amount, this.cart}) : super([cart, amount]);

  @override
  String toString() {
    return "Adding cart : ${cart.id}";
  }
}

class CartToggle extends CartEvent {
  final Cart cart;
  CartToggle({this.cart}) : super([cart]);

  @override
  String toString() {
    return "Toggle cart : ${cart.id}";
  }
}
