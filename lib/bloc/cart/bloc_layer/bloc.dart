import 'package:pertani_shop/bloc/cart/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/models/cart.dart';

class CartBloc extends Bloc<CartEvent, CartStates> {
  @override
  CartStates get initialState => CartUninitialized();

  @override
  Stream<CartStates> mapEventToState(CartEvent event) async* {
    try {
      if (event is FetchCart) {
        print("fetching cart");
        yield CartFetching();
        await Future.delayed(Duration(seconds: 5));
        yield CartInitialized(carts: []);
        return;
      }
      if (event is AddCart) {
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
      if (event is ToggleCart) {
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
      if (event is UpdateAmountCart) {
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
    } catch (e) {
      print(e);
    }
  }
}
