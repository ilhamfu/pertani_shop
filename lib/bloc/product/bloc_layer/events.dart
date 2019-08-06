abstract class ProductEvent{

}

class FetchAllProduct extends ProductEvent{
  final Map<String,dynamic> filter;

  FetchAllProduct({this.filter});
}

class FetchProduct extends ProductEvent{
  final int id;

  FetchProduct(this.id);
}