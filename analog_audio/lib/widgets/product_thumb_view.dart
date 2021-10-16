import 'package:analog_audio/providers/product.dart';
import 'package:analog_audio/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductThumbView extends StatelessWidget {
  final Product product;
  final bool dense;

  const ProductThumbView({
    Key? key,
    required this.product,
    this.dense = false,
  }) : super(key: key);

  BorderRadius get getBorderRadius {
    return BorderRadius.circular(8.0);
  }

  void navigateToDetails(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
  }

  Widget getImageStack(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: getBorderRadius,
            image: DecorationImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Theme.of(context).splashColor,
                splashFactory: Theme.of(context).splashFactory,
                borderRadius: getBorderRadius,
                onTap: () => navigateToDetails(context)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
              tag: product.id,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: getBorderRadius,
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          splashFactory: Theme.of(context).splashFactory,
                          borderRadius: getBorderRadius,
                          onTap: () => navigateToDetails(context)),
                    ),
                  )
                ],
              ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            overflow: dense ? TextOverflow.ellipsis : TextOverflow.visible,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '\$${product.price}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      onTap: () => navigateToDetails(context),
    );
  }
}
