import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartStates extends Equatable {
  CartStates([List props = const []]) : super(props);
}

class CartUninitialized extends CartStates {
  @override
  String toString() {
    // TODO: implement toString
    return "Cart Uninitialized";
  }
}

class CartFetching extends CartStates{

}

class CartInitialized extends CartStates {
  CartInitialized({this.carts}) : super([carts]);
  final List<Cart> carts;

  int get length => carts.length;
  int get total => isEmpty?0:carts.map<int>((e)=>e.active?e.total:0).reduce((v,e)=>v+e);
  bool get isEmpty => carts.length<=0;

  @override
  String toString() {
    return "Cart Initialized";
  }
}

class CartError extends CartStates {
  final String error;

  CartError({this.error}) : super([error]);
  String toString() {
    return "Error : $error";
  }
}
