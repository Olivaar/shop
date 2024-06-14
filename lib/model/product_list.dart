import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/model/product.dart';
import '../utils/constants.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-b082a-default-rtdb.firebaseio.com';
  final String _token;
  final String _userId;
  final List<Product> _items;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  ProductList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response =
        await http.get(Uri.parse('$_baseUrl/products.json?auth=$_token'));

    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
          '${Constants.BASE_URL}/userFavorites/$_userId.json?auth=$_token'),
    );

    final Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json?auth=$_token'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/products/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_baseUrl/products/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          message: 'Nao foi possivel excluir o produto',
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
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
