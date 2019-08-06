import 'package:pertani_shop/bloc/product_category/data_layer/api_client.dart';
import 'package:pertani_shop/models/product_category.dart';

class CategoryRepository{
  final CategoryApiClient categoryApiClient = CategoryApiClient();

  Future<List<ProductCategory>> fetch() => categoryApiClient.fetch();
}