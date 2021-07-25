import 'dart:convert';
import 'dart:math';

import 'package:analog_audio/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;

  Products(this.userId, this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProduct() async {
    var url = Uri.parse(
        'https://analog-audio-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final encodedBody = json.decode(response.body);

      if (encodedBody == null) {
        return;
      }

      final extractedData = encodedBody as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach(
        (productId, productData) => loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
          ),
        ),
      );

      _items = loadedProducts;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
