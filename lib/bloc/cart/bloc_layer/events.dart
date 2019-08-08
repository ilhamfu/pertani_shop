import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartEvent extends Equatable {
  CartEvent([List props = const []]) : super(props);
}

class FetchCart extends CartEvent {
  @override
  String toString() {
    return "Fetching cart";
  }
}

class UpdateAmountCart extends CartEvent {
  final Cart cart;
  final int amount;
  UpdateAmountCart({this.amount, this.cart}) : super([cart,amount]);

  @override
  String toString() {
    return "Fetching cart : ${cart.id}";
  }
}

class DismissCart extends CartEvent {
  final Cart cart;

  DismissCart({this.cart}) : super([cart]);

  @override
  String toString() {
    return "Dismising cart : ${cart.id}";
  }
}

class AddCart extends CartEvent {
  final Cart cart;
  final int amount;
  AddCart({this.amount, this.cart}) : super([cart,amount]);

  @override
  String toString() {
    return "Adding cart : ${cart.id}";
  }
}

class ToggleCart extends CartEvent {
  final Cart cart;
  ToggleCart({this.cart}):
        super([cart]);

  @override
  String toString() {
    return "Toggle cart : ${cart.id}";
  }
}
