class ProductCategory {
  int _id;
  String _name;

  int get id=>_id;
  String get name=>_name;

  ProductCategory({int id, String name})
      : _id = id,
        _name = name;

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(id: map["id"], name: map["name"]);
  }
}
