import 'dart:convert';

import 'package:apparel/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/orders.json');
    final dateTime = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': dateTime.toIso8601String(),
        'products': cartProducts.map((prdt) => {
              'id': prdt.id,
              'title': prdt.title,
              'quantities': prdt.quantities,
              'price': prdt.price,
            }).toList()
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }
}
