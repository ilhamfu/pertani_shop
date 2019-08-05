import 'package:rxdart/rxdart.dart';

class ProductStream {
  BehaviorSubject _products = BehaviorSubject.seeded([
    {
      "id": 75,
      "category": {"id": 1, "name": "Padi"},
      "imageList": [],
      "name": "ad est",
      "stock": 94,
      "avgRate": 0.0,
      "price": 4000
    },
    {
      "id": 87,
      "category": {"id": 5, "name": "Jagung"},
      "imageList": [],
      "name": "adipisicing consequat",
      "stock": 56,
      "avgRate": 0.0,
      "price": 3000
    },
    {
      "id": 4,
      "category": {"id": 2, "name": "Beras"},
      "imageList": [],
      "name": "adipisicing dolor",
      "stock": 55,
      "avgRate": 0.0,
      "price": 8000
    },
    {
      "id": 85,
      "category": {"id": 5, "name": "Jagung"},
      "imageList": [],
      "name": "aliqua sint",
      "stock": 45,
      "avgRate": 0.0,
      "price": 13000
    },
    {
      "id": 96,
      "category": {"id": 4, "name": "Benih Jagung"},
      "imageList": [],
      "name": "aliquip veniam",
      "stock": 30,
      "avgRate": 0.0,
      "price": 6000
    },
    {
      "id": 100,
      "category": {"id": 7, "name": "Pupuk"},
      "imageList": [],
      "name": "amet cillum",
      "stock": 55,
      "avgRate": 0.0,
      "price": 5000
    },
    {
      "id": 22,
      "category": {"id": 6, "name": "Obat-obatan"},
      "imageList": [],
      "name": "amet fugiat",
      "stock": 96,
      "avgRate": 0.0,
      "price": 2000
    },
    {
      "id": 51,
      "category": {"id": 3, "name": "Benih Padi"},
      "imageList": [],
      "name": "amet quis",
      "stock": 52,
      "avgRate": 0.0,
      "price": 4000
    },
    {
      "id": 19,
      "category": {"id": 7, "name": "Pupuk"},
      "imageList": [],
      "name": "anim minim",
      "stock": 44,
      "avgRate": 0.0,
      "price": 17000
    },
    {
      "id": 84,
      "category": {"id": 2, "name": "Beras"},
      "imageList": [],
      "name": "cillum qui",
      "stock": 74,
      "avgRate": 0.0,
      "price": 10000
    },
    {
      "id": 30,
      "category": {"id": 5, "name": "Jagung"},
      "imageList": [],
      "name": "commodo cillum",
      "stock": 54,
      "avgRate": 0.0,
      "price": 16000
    },
    {
      "id": 29,
      "category": {"id": 2, "name": "Beras"},
      "imageList": [],
      "name": "commodo nostrud",
      "stock": 26,
      "avgRate": 0.0,
      "price": 9000
    },
    {
      "id": 50,
      "category": {"id": 6, "name": "Obat-obatan"},
      "imageList": [],
      "name": "consectetur Lorem",
      "stock": 93,
      "avgRate": 0.0,
      "price": 20000
    },
    {
      "id": 83,
      "category": {"id": 4, "name": "Benih Jagung"},
      "imageList": [],
      "name": "consequat Lorem",
      "stock": 36,
      "avgRate": 0.0,
      "price": 5000
    },
    {
      "id": 7,
      "category": {"id": 1, "name": "Padi"},
      "imageList": [],
      "name": "culpa nostrud",
      "stock": 45,
      "avgRate": 0.0,
      "price": 20000
    },
    {
      "id": 59,
      "category": {"id": 6, "name": "Obat-obatan"},
      "imageList": [],
      "name": "culpa sit",
      "stock": 71,
      "avgRate": 0.0,
      "price": 13000
    },
    {
      "id": 86,
      "category": {"id": 5, "name": "Jagung"},
      "imageList": [],
      "name": "culpa voluptate",
      "stock": 97,
      "avgRate": 0.0,
      "price": 9000
    },
    {
      "id": 93,
      "category": {"id": 4, "name": "Benih Jagung"},
      "imageList": [],
      "name": "cupidatat eiusmod",
      "stock": 57,
      "avgRate": 0.0,
      "price": 8000
    },
    {
      "id": 24,
      "category": {"id": 5, "name": "Jagung"},
      "imageList": [],
      "name": "cupidatat voluptate",
      "stock": 49,
      "avgRate": 0.0,
      "price": 16000
    },
    {
      "id": 48,
      "category": {"id": 4, "name": "Benih Jagung"},
      "imageList": [],
      "name": "deserunt deserunt",
      "stock": 31,
      "avgRate": 0.0,
      "price": 12000
    }
  ]);

  Observable get stream$ => _products.stream;

  List<Map<String, dynamic>> get current => _products.value;
}
