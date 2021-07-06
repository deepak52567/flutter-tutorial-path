import 'package:apparel/providers/orders.dart' show Orders;
import 'package:apparel/widgets/app_drawer.dart';
import 'package:apparel/widgets/order_item.dart' show OrderItem;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Here we could have also used a stateless widget
  // But if some dialog opens or anything that essentially
  // rebuilds the widget then it will recall orders future
  // Unnecessary. To avoid it, we are using and assigning this to
  // an outer method in a stateful widget. Although stateless widget
  // is recommended
  late Future _ordersFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // To avoid infinite loop and after futureBuilder finishes it pings Orders Provider about
    // updated data then it calls build method again and again it run Future builder
    // So on!
    // final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (futureBuilderCtx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              // Error handling
              return Center(
                child: const Text('Error Occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (consumerCtx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (consumerCtx, index) =>
                      OrderItem(order: orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
