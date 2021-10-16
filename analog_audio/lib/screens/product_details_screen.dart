import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/products.dart';
import 'package:analog_audio/widgets/custom_icon_button.dart';
import 'package:analog_audio/widgets/custom_sliver_app_bar.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.5,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            leading: CustomIconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icons.arrow_back_ios_rounded,
              type: ButtonStyleType.Filled,
              lightShade: true,
            ),
            flexibleSpace: Hero(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    //your image
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
              tag: productId,
            ),
          ),
        ],
      ),
    );
  }
}
