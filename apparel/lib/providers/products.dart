import 'dart:convert';

import 'package:apparel/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Always add provider class to highest possible point of interested widgets
// with mixin ChangeNotifier
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Prananta haroun Jacket',
      description:
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident',
      price: 29.99,
      imageUrl:
      'https://images.unsplash.com/photo-1614039366327-6beb371a2a3d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=prananta-haroun-aQ8TqM85BcQ-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p2',
      title: 'Cade Prior White Top',
      description:
      'Iscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ',
      price: 59.99,
      imageUrl:
      'https://images.unsplash.com/photo-1615056698579-7430b9f2d36c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=cade-prior-DgvvCcPYn2Y-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p3',
      title: 'Dave Goudreau Shirt',
      description:
      'Omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi',
      price: 19.99,
      imageUrl:
      'https://images.unsplash.com/photo-1617159526373-1fbfdcb33b12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=dave-goudreau-JhdjxaBvj4k-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p4',
      title: 'Jade Green Hoodie',
      description:
      'Eemely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain s',
      price: 49.99,
      imageUrl:
      'https://images.unsplash.com/photo-1622765109949-4e6bbce8a54e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=jade-scarlato-UkQoBiQ9Ipg-unsplash.jpg&w=640',
    ),
  ];

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

  void addProduct(Product product) {

    final url = Uri.parse('https://apparel-flutter-default-rtdb.firebaseio.com/products.json');
    http.post(url, body: json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'isFavorite': product.isFavorite,
      'imageUrl': product.imageUrl
    }), headers: {
      'Content-Type': 'application/json'
    });
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    // To add it on top of the list
    // _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prdtIndex = _items.indexWhere((prdt) => prdt.id == id);
    if (prdtIndex >= 0) {
      _items[prdtIndex] = newProduct;
      notifyListeners();
    } else {
      print('... not found');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prdt) => prdt.id == id);
    notifyListeners();
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
