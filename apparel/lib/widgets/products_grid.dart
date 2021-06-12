import 'package:apparel/providers/products_provider.dart';
import 'package:apparel/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    // Listing to parent provider
    // Helps to setup connect with direct/indirect widget provided class
    // Only this widget will rebuild on change
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;

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
        // If interested in context of itemBuilder then use this
        // return ChangeNotifierProvider(
        //   create: (c) => products[index],
        //   child: ProductItem(),
        // );
        // IF doesn't depend on context
        // Always prefer value method of ChangeNotifierProvider method
        // It make sure that provider works even if data is changes in an widget and builder will not work correctl
        // Its kind of detached from widget. Kind of useful in grid or list types.
        // Use value approach if using it in existing objects. Like list or grid items.
        // ChangeNotifierProvider automatically cleanup the providers data
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
