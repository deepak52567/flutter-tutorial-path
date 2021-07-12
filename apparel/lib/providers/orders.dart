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
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final dateTime = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': dateTime.toIso8601String(),
        'products': cartProducts
            .map((prdt) => {
                  'id': prdt.id,
                  'title': prdt.title,
                  'quantities': prdt.quantities,
                  'price': prdt.price,
                })
            .toList()
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

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://apparel-flutter-default-rtdb.firebaseio.com/orders$userId.json?auth=$authToken');
    final response = await http.get(url);
    final encodedBody = json.decode(response.body);

    if (encodedBody == null) {
      return;
    }

    final List<OrderItem> loadedOrders = [];
    // Converting it to a map which has its id as key and other values
    final extractedData = encodedBody as Map<String, dynamic>;

    extractedData.forEach((orderID, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderID,
          amount: orderData['amount'],
          // Changing order items into dynamic list to use it as product map
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantities: item['quantities'],
                  ))
              .toList(),
          dateTime: DateTime.parse(
            orderData['dateTime'],
          ),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
