import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantities;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantities,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(
    String productID,
    double price,
    String title,
  ) {
    if (_items.containsKey(productID)) {
      _items.update(
          productID,
          (existingItem) => CartItem(
                id: existingItem.id,
                title: existingItem.title,
                price: existingItem.price,
                quantities: existingItem.quantities + 1,
              ));
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantities: 1,
              price: price));
    }
  }
}
