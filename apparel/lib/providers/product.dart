import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Changing product model into changeNotifier class to tell widgets about any change, i.e isFavorite
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newVal) {
    isFavorite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final existingStatus = isFavorite;
    _setFavValue(!isFavorite);
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': !existingStatus,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(existingStatus);
      }
    } catch (err) {
      _setFavValue(existingStatus);
    }
  }
}
