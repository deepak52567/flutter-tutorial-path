import 'package:apparel/providers/cart.dart';
import 'package:apparel/providers/product.dart';
import 'package:apparel/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider stops at products_grid till it finds ChangeNotifierProvider class
    // By merging both Provider and Consumer class, we can get data once using
    // Provider then listen to changes using Consumer and prevent full Widget re-rendering
    // And only re-renders the icon button
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    // We can also use Consumer Widget to update specific parts of Widget instead of rerendring the whole widget
    // when using Provider.of
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        // To add invisible onTap function
        child: GestureDetector(
          onTap: () {
            // On the fly routes sometimes difficult to manage on large apps
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ProductDetailScreen(title),
            // ));
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, prdt, child) => IconButton(
              // Can also refer child reference to a widget down to type Never Changes
              // If we still want to contain some widget fixed in case of re-render
              // icon: child!,
              icon: Icon(
                  prdt.isFavorite ? Icons.favorite : Icons.favorite_outline),
              onPressed: () => prdt.toggleFavoriteStatus(),
              color: Theme.of(context).accentColor,

            ),
            // child: Text('Never changes'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              // Using scaffold, we can reach nearest scaffold and call few method related to it
              // Scaffold.of(context).openDrawer();
              // Remove exiting snackbar
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added to Cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      //Remove single item for cart
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
