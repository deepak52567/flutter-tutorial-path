import 'package:apparel/providers/cart.dart';
import 'package:apparel/providers/orders.dart';
import 'package:apparel/providers/products.dart';
import 'package:apparel/screens/cart_screen.dart';
import 'package:apparel/screens/orders_screen.dart';
import 'package:apparel/screens/product_detail_screen.dart';
import 'package:apparel/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Allows us to register a class which can be listen by child widget will rebuild.
    // Only child.
    //Listening widget will rebuild. Like any child widget
    // user value() method of ChangeNotifierProvider if not interested in context
    // When using create a new object based on a class. We should use create method.
    // Use value approach if using it in existing objects. Like list or grid items.
    // To user multiple providers, use MultiProvider widget and providers in the array
    return MultiProvider(
      providers: [
        // Not provider, lstners cause the re-renders
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Apparel App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
