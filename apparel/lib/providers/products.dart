import 'dart:convert';

import 'package:apparel/models/http_exception.dart';
import 'package:apparel/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Always add provider class to highest possible point of interested widgets
// with mixin ChangeNotifier
class Products with ChangeNotifier {
  List<Product> _items = [];

  // bool _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prdt) => prdt.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prdt) => prdt.isFavorite).toList();
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractData.forEach(
        (prdtID, prdtData) => loadedProducts.add(
          Product(
            id: prdtID,
            title: prdtData['title'],
            description: prdtData['description'],
            price: prdtData['price'],
            imageUrl: prdtData['imageUrl'],
            isFavorite: prdtData['isFavorite'],
          ),
        ),
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    // In flutter, after Futures of catchError() will be executed after an error

    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'imageUrl': product.imageUrl
          }),
          headers: {'Content-Type': 'application/json'});
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      // To add it on top of the list
      // _items.insert(0, newProduct);
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prdtIndex = _items.indexWhere((prdt) => prdt.id == id);
    if (prdtIndex >= 0) {
      try {
        final url = Uri.parse(
            'https://apparel-flutter-default-rtdb.firebaseio.com/products/$id.json');
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl
            }));
        _items[prdtIndex] = newProduct;
        notifyListeners();
      } catch (err) {
        print(err);
        throw err;
      }
    } else {
      print('... not found');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/products/$id.json');
    // We are only removing item from the list but not from memory as we are storing here in an variable
    int existingProductIndex = _items.indexWhere((prdt) => prdt.id == id);
    // Using index to store a object to from the item list itself
    Product? existingProduct = _items[existingProductIndex];

    // Optimistic response
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

// Applicable on AppWide state changes
// void showFavoritesOnly() {
//   _showFavoritesOnly = true;
//   notifyListeners();
// }
//
// void showAllProduct() {
//   _showFavoritesOnly = false;
//   notifyListeners();
// }
}
