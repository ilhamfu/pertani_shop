import 'package:pertani_shop/bloc/product/data_layer/api_client.dart';
import 'package:pertani_shop/models/product.dart';

class ProductRepository{
  final ProductApiClient _apiClient = ProductApiClient();

  Future<List<Product>> fetchAll() => _apiClient.fetchData();

}