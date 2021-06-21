import 'package:apparel/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.title, this.price, this.id, this.productId, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: Card(
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
      ),
      // add a unique key to differentiate
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 25,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // removes item based on its key
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
    );
  }
}
