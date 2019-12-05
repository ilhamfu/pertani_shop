import 'package:pertani_shop/bloc/product_list/bloc/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/product_list/repository/api_client.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  @override
  ProductListState get initialState => ProductListUninitialized();

  final ProductListApiClient _productListApiClient = ProductListApiClient();

  @override
  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    if (event is ProductListInitialize) {
      yield* _mapProductListInitialize();
    } else if (event is ProductListFetch) {
      yield* _mapProductListFetch(event);
    }
  }

  Stream<ProductListState> _mapProductListInitialize() async* {
    yield ProductListStatus(status: ProductListStatus.PRODUCT_LIST_FETCHING);
    final data = await _productListApiClient.fetchProduct();
    yield ProductListInitialized(product: data);
  }

  Stream<ProductListState> _mapProductListFetch(ProductListFetch event) async *{
    yield ProductListStatus(status: ProductListStatus.PRODUCT_LIST_FETCHING);
    final data = await _productListApiClient.fetchProduct();
    yield ProductListInitialized(product: data);
  }
}
