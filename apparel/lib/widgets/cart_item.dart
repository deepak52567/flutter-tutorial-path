import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.title, this.price, this.id, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$${(price)}')),
          ),
          trailing: Text('${(quantity)} x'),
          title: Text(title),
          subtitle: Text('\$${(price * quantity)}'),
        ),
      ),
    );
  }
}
