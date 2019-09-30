import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartEvent extends Equatable {
  CartEvent([List props = const []]) : super(props);
}

class CartFetch extends CartEvent {}

class CartUpdate extends CartEvent {
  final Cart cart;

  CartUpdate({this.cart});
}

class CartDelete extends CartEvent {
  final Cart cart;

  CartDelete({this.cart});
}

class CartCreate extends CartEvent {
  final Cart cart;

  CartCreate({this.cart});
}
