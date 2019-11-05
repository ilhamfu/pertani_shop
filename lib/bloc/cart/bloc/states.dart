import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartUninitialized extends CartState {}

class CartInitialized extends CartState {
  final List<Cart> carts;

  get length => carts.length;
  get total => carts.fold(0,(temp,data)=>temp+data.total);
  get empty => carts.length == 0;

  CartInitialized({this.carts}) : super([carts]);
}

class CartStatus extends CartState {
  final int status;
  static const int CART_FETCHING = 0;
  static const int CART_UPDATING = 1;
  static const int CART_DELETING = 2;
  static const int CART_CREATING = 3;
  static const int CART_ERROR = 4;

  CartStatus({this.status}):super([status]);

}
