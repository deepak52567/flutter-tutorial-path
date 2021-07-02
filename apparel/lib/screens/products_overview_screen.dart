import 'package:apparel/providers/cart.dart';
import 'package:apparel/providers/products.dart';
import 'package:apparel/screens/cart_screen.dart';
import 'package:apparel/widgets/app_drawer.dart';
import 'package:apparel/widgets/badge.dart';
import 'package:apparel/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavrtData = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Products>(context)
          .fetchAndSetProduct()
          .then((_) => setState(() => _isLoading = false));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // In init state can't use context here
    //Although we can use provider using listen to false as a workaround
    // Provider.of<Products>(context).fetchAndSetProduct(); // WON'T WORK

    // This can also be used as HACK because we are using delayed as a workaround
    // Future.delayed(Duration.zero).then((_) => {
    //   Provider.of<Products>(context).fetchAndSetProduct()
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apparel Catalogue'),
        actions: <Widget>[
          Consumer<Cart>(
            // Provided child Icon to prevent unnecessary rebuild of icon
            builder: (_, cartData, ch) => Badge(
              child: ch!,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showOnlyFavrtData = true;
                } else {
                  _showOnlyFavrtData = false;
                }
              });
            },
            icon: Icon(Icons.filter_alt),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavrtData),
    );
  }
}
