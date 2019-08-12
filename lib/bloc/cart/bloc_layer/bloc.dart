import 'package:pertani_shop/bloc/cart/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/models/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartUninitialized();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    try {
      if (event is FetchCart) {
        if ((currentState is CartUninitialized) || !event.initialFetch) {
          yield CartOnProcess(processCode: CartOnProcess.ON_FETCHING);
          await Future.delayed(Duration(seconds: 5));
          yield CartInitialized(carts: []);
          return;
        }
      }
      if (event is CartCreate) {
        if (currentState is CartInitialized) {
          var cart = (currentState as CartInitialized).carts;
          var pos = cart.indexOf(event.cart);
          if (pos < 0)
            yield CartInitialized(
                carts: List<Cart>.from(cart)..add(event.cart));
          else {
            Cart oldCart = cart[pos];

            yield CartInitialized(
                carts: List<Cart>.from(cart)
                  ..removeAt(pos)
                  ..insert(
                      pos,
                      Cart.copyFrom(oldCart,
                          amount: (oldCart.amount + event.cart.amount))));
          }
        }
        return;
      }

      if (event is CartToggle) {
        if (currentState is CartInitialized) {
          var cart = (currentState as CartInitialized).carts;
          var pos = cart.indexOf(event.cart);
          if (pos < 0) return;
          yield CartInitialized(
              carts: List<Cart>.from(cart)
                ..removeAt(pos)
                ..insert(pos,
                    Cart.copyFrom(event.cart, active: !event.cart.active)));
        }
        return;
      }
      if (event is CartUpdateAmount) {
        if (currentState is CartInitialized) {
          var cart = (currentState as CartInitialized).carts;
          var pos = cart.indexOf(event.cart);
          if (pos < 0) return;
          yield CartInitialized(
              carts: List<Cart>.from(cart)
                ..removeAt(pos)
                ..insert(pos, Cart.copyFrom(event.cart, amount: event.amount)));
        }
        return;
      }

      if (event is CartDelete) {
        if (currentState is CartInitialized) {
          var cart = (currentState as CartInitialized).carts;
          var pos = cart.indexOf(event.cart);
          if (pos < 0) return;
          yield CartInitialized(carts: List<Cart>.from(cart)..removeAt(pos));
        }
        return;
      }
    } catch (e) {
      yield CartError(error: e);
    }
  }
}
