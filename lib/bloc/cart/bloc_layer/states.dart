import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/cart.dart';

abstract class CartState extends Equatable {
  CartState([List props = const []]) : super(props);
}

class CartUninitialized extends CartState {
  @override
  String toString() {
  
    return "Cart Uninitialized";
  }
}

class CartOnProcess extends CartState {
  final int processCode;

  static const int ON_FETCHING = 0;
  static const int ON_CREATING = 1;
  static const int ON_CANCELING = 2;

  CartOnProcess({this.processCode}) : super([processCode]);

  @override
  String toString() {
    return "Processing cart : $processCode";
  }
}

class CartInitialized extends CartState {
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

class CartError extends CartState {
  final String error;

  CartError({this.error}) : super([error]);
  String toString() {
    return "Error : $error";
  }
}
