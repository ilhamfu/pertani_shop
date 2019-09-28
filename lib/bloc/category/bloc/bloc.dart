import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/category/bloc/index.dart';
import 'package:pertani_shop/bloc/category/repository/api_client.dart';
import 'package:pertani_shop/models/product_category.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final CategoryApiClient _categoryApiClient = CategoryApiClient();

  @override
  CategoryState get initialState => CategoryUninitialized();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryInitialize) {
      yield* _initiateCategory();
    }
  }

  Stream<CategoryState> _initiateCategory() async* {
    yield CategoryStatus(status: CategoryStatus.CATEGORY_FETCHING);
    final data = await _categoryApiClient.fetchCategory();
    yield CategoryInitialized(category: data);
  }
}
