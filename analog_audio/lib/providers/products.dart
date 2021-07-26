import 'dart:convert';

import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/product.dart';
import 'package:flutter/foundation.dart';
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

  List<Product> get headphoneProducts {
    return _items
        .where((prdt) => prdt.type == describeEnum(ProductType.Headphones))
        .toList();
  }

  List<Product> get accessoriesProducts {
    return _items
        .where((prdt) => prdt.type == describeEnum(ProductType.Accessories))
        .toList();
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
            type: productData['type'],
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
