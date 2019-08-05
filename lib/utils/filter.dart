import 'package:pertani_shop/models/product_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class FilterStream{
  BehaviorSubject<Map<String,dynamic>> _filter = BehaviorSubject<Map<String,dynamic>>.seeded({
    "category": {"id": -1, "name": ""},
    "price": {
      "max": -1,
      "min": -1,
    },
    "name": "",
    "star": 0
  });

  Map<String,dynamic> get filter => _filter.value;
  Observable get filterStream => _filter.stream;

  setPrice({int max:-1,int min:-1}){
    Map<String,dynamic> data = Map.from(filter);
    data["price"] = {
      "max":max,
      "min":min,
    };
    _filter.add(data);
  }

  setStar(int amount){
    Map<String,dynamic> data = Map.from(filter);
    
    data["star"] = data["star"]==amount?-1:amount;
    _filter.add(data);
  }

  setName(String name){
    Map<String,dynamic> data = Map.from(filter);
    data["name"] = name;
    _filter.add(data);
  }

  setCategory({ProductCategory category}){
    Map<String,dynamic> data = Map.from(filter);
    if (category!=null && data["category"]["id"]!=category.id){
      data["category"]["id"] = category.id;
      data["category"]["name"] = category.name;
    }else{
      data["category"]["id"] = -1;
    }
    _filter.add(data);
  }

}