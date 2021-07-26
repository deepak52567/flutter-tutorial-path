import 'package:analog_audio/providers/product.dart';
import 'package:flutter/material.dart';

class ProductThumbView extends StatelessWidget {
  final Product product;

  const ProductThumbView({
    Key? key,
    required this.product
  }) : super(key: key);

  BorderRadius get getBorderRadius {
    return BorderRadius.circular(8.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
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
                    onTap: () {}),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          product.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '\$${product.price}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}