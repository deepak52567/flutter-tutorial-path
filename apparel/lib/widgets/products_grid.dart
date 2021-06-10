import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel/providers/products_provider.dart';
import 'package:apparel/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listing to parent provider
    // Helps to setup connect with direct/indirect widget provided class
    // Only this widget will rebuild on change
    final productData = Provider.of<Products>(context);
    final products = productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider(
          create: (c) => products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
