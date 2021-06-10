import 'package:apparel/providers/product.dart';
import 'package:apparel/widgets/products_grid.dart';
import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apparel Catalogue')),
      body: ProductsGrid(),
    );
  }
}
