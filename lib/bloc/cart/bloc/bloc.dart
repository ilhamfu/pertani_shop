import "package:pertani_shop/bloc/cart/bloc/index.dart";
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/models/cart.dart';
import 'package:pertani_shop/models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartUninitialized();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartFetch) {
      yield* _mapCartFetchToState();
    } else if (event is CartDelete) {
      yield* _mapCartDeleteToState();
    } else if (event is CartUpdate) {
      yield* _mapCartUpdateToState();
    } else if (event is CartCreate) {
      yield* _mapCartCreateToState();
    }
  }

  Stream<CartState> _mapCartFetchToState() async* {
    yield CartInitialized(carts: [
      new Cart(active: true,amount: 1,id: 0,product: Product(id: 0,imageList: ["https://picsum.photos/100/100"],price: 20000,name:"product1"))
    ]);
  }
  Stream<CartState> _mapCartUpdateToState() async* {
    yield CartInitialized(carts: []);
  }
  Stream<CartState> _mapCartDeleteToState() async* {
    yield CartInitialized(carts: []);
  }
  Stream<CartState> _mapCartCreateToState() async* {
    yield CartInitialized(carts: []);
  }
}
