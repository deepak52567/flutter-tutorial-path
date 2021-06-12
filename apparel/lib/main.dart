import 'package:apparel/providers/products_provider.dart';
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
    return ChangeNotifierProvider(
      create: (_) => Products(),
      child: MaterialApp(
        title: 'Apparel App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}
