import 'package:analog_audio/models/enums.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String type;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.type,
    this.isFavorite = false,
  });

  void toggleFavorite(bool newFavVal) {
    isFavorite = newFavVal;
    notifyListeners();
  }
}
