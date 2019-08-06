import 'package:pertani_shop/bloc/product/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/product/data_layer/repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final ProductRepository productRepository = ProductRepository();

  @override
  ProductState get initialState => ProductUninitalized();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchAllProduct) {
      final product = await productRepository.fetchAll();
      yield ProductInitialized(product: product);
    }
  }
}
