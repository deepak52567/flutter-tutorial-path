import 'package:apparel/providers/products.dart';
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
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      //   actions: [
      //     IconButton(
      //       onPressed: null,
      //       icon: Icon(
      //         loadedProduct.isFavorite
      //             ? Icons.favorite
      //             : Icons.favorite_outline,
      //       ),
      //       color: Theme.of(context).accentColor,
      //     )
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: productId,
                child: Image.network(
                  loadedProduct.imageUrl,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
