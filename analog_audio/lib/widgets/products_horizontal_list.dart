import 'package:analog_audio/widgets/product_thumb_view.dart';
import 'package:flutter/material.dart';

class ProductHorizontalList extends StatelessWidget {
  final String listTitle;
  final Size size;
  final Function showAll;

  const ProductHorizontalList(
      {Key? key,
      required this.size,
      required this.listTitle,
      required this.showAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    '41',
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: double.infinity,
                width: (size.width * 0.5),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                child: ProductThumbView(),
              ),
              Container(
                height: double.infinity,
                width: (size.width * 0.5),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ProductThumbView(),
              ),
              Container(
                height: double.infinity,
                width: (size.width * 0.5),
                margin: EdgeInsets.only(left: 10, right: 20),
                child: ProductThumbView(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
