import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/model/product.dart';
import '../data/dummy_data.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if(hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }

  }
}

// bool _shoFavoriteOnly = false;
//
// List<Product> get items {
//   if(_shoFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//   return [..._items];
// }
//
// void showFavoritesOnly(){
//   _shoFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll(){
//   _shoFavoriteOnly = false;
//   notifyListeners();
// }
