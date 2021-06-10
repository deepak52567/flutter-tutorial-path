import 'package:apparel/providers/product.dart';
import 'package:apparel/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Provider stops at products_grid till it finds ChangeNotifierProvider class
    final product = Provider.of<Product>(context);
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
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
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
          leading: IconButton(
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_outline),
            onPressed: () => product.toggleFavoriteStatus(),
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
