import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/products.dart';
import 'package:analog_audio/widgets/product_thumb_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductHorizontalList extends StatelessWidget {
  final String listTitle;
  final Size size;
  final Function showAll;
  final ProductType prdtType;

  const ProductHorizontalList({
    Key? key,
    required this.size,
    required this.listTitle,
    required this.showAll,
    required this.prdtType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        describeEnum(prdtType) == describeEnum(ProductType.Headphones)
            ? productsData.headphoneProducts
            : productsData.accessoriesProducts;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    listTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    products.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.grey.shade200),
                  ),
                ],
              ),
              TextButton(
                child: Text('Show all'),
                onPressed: () => showAll(),
                style: Theme.of(context).textButtonTheme.style,
              ),
            ],
          ),
        ),
        Container(
          height: size.height * 0.30,
          child: ListView.builder(
            itemCount: products.length > 3 ? 3 : products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => Container(
              height: double.infinity,
              width: (size.width * 0.5),
              margin: EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              child: ProductThumbView(
                product: products[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
