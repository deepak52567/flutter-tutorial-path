import 'package:apparel/providers/products.dart';
import 'package:apparel/screens/edit_product_screen.dart';
import 'package:apparel/widgets/app_drawer.dart';
import 'package:apparel/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                key: ValueKey(productsData.items[index].id + DateTime.now().toString()),
                id: productsData.items[index].id,
                title: productsData.items[index].title,
                image: productsData.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
