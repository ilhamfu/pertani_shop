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
      new Cart(active: true,amount: 650,id: 0,product: Product(id: 0,imageList: ["https://picsum.photos/100/100"],price: 30000,name:"product 1")),
      new Cart(active: true,amount: 1000,id: 1,product: Product(id: 0,imageList: ["https://picsum.photos/100/100"],price: 25000,name:"product 2")),
      new Cart(active: true,amount: 100,id: 2,product: Product(id: 0,imageList: ["https://picsum.photos/100/100"],price: 33000,name:"product 3")),
      new Cart(active: true,amount: 10,id: 3,product: Product(id: 0,imageList: ["https://picsum.photos/100/100"],price: 80000,name:"product 4")),
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
