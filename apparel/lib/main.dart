import 'package:apparel/providers/auth.dart';
import 'package:apparel/providers/cart.dart';
import 'package:apparel/providers/orders.dart';
import 'package:apparel/providers/products.dart';
import 'package:apparel/screens/auth_screen.dart';
import 'package:apparel/screens/cart_screen.dart';
import 'package:apparel/screens/edit_product_screen.dart';
import 'package:apparel/screens/orders_screen.dart';
import 'package:apparel/screens/product_detail_screen.dart';
import 'package:apparel/screens/products_overview_screen.dart';
import 'package:apparel/screens/user_products_screen.dart';
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
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // Not provider, listeners cause the re-renders
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (BuildContext ctx, Auth auth, Products? products) => Products(
            auth.userId != null ? auth.userId! : '',
            auth.token != null ? auth.token! : '',
            products!.items != null ? products.items : [],
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', []),
          update: (BuildContext ctx, Auth auth, Orders? previousOrders) =>
              Orders(
            auth.token != null ? auth.token! : '',
            previousOrders!.orders != null ? previousOrders.orders : [],
          ),
        ),
      ],
      // So being material app itself a widget here. We can simply rebuild it based
      // on the auth data itself instead of calling build method on auth change.
      // Using Consumer
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          title: 'Apparel App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
