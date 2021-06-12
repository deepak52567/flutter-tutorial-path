import 'package:apparel/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // const ProductDetailScreen(this.title, {Key? key}) : super(key: key);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    // If only want data one time
    // If we don't wanna rebuild widget on data change, we can change listen to false. Default is true
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    // final loadedProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(loadedProduct.isFavorite
                ? Icons.favorite
                : Icons.favorite_outline, ),
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
