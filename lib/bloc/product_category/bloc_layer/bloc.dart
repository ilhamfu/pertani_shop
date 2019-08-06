import 'package:pertani_shop/bloc/product_category/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/product_category/data_layer/repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository = CategoryRepository();

  @override
  CategoryState get initialState => CategoryUninitialized();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory) {
      print("event dispatched");
      final category = await categoryRepository.fetch();
      print("fetch fiished");
      yield CategoryInitialized(category: category);
    }
  }
}
