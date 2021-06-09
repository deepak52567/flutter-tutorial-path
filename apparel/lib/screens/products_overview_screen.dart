import 'package:apparel/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:apparel/models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    Product(
      id: 'p1',
      title: 'Prananta haroun Jacket',
      description:
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident',
      price: 29.99,
      imageUrl:
          'https://images.unsplash.com/photo-1614039366327-6beb371a2a3d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=prananta-haroun-aQ8TqM85BcQ-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p2',
      title: 'Cade Prior White Top',
      description:
          'Iscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1615056698579-7430b9f2d36c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=cade-prior-DgvvCcPYn2Y-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p3',
      title: 'Dave Goudreau Shirt',
      description:
          'Omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1617159526373-1fbfdcb33b12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=dave-goudreau-JhdjxaBvj4k-unsplash.jpg&w=640',
    ),
    Product(
      id: 'p4',
      title: 'Jade Green Hoodie',
      description:
          'Eemely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain s',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1622765109949-4e6bbce8a54e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=jade-scarlato-UkQoBiQ9Ipg-unsplash.jpg&w=640',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apparel Catalogue')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return ProductItem(
            loadedProducts[index].id,
            loadedProducts[index].title,
            loadedProducts[index].imageUrl,
          );
        },
      ),
    );
  }
}
