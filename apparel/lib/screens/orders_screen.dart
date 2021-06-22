import 'package:apparel/providers/orders.dart' show Orders;
import 'package:apparel/widgets/app_drawer.dart';
import 'package:apparel/widgets/order_item.dart' show OrderItem;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context, index) => OrderItem(
          order: orders.orders[index],
        ),
      ),
    );
  }
}
