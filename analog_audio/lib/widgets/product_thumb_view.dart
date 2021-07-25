import 'package:flutter/material.dart';

class ProductThumbView extends StatelessWidget {
  const ProductThumbView({
    Key? key,
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
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1546435770-a3e426bf472b?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=tomasz-gawlowski-YDZPdqv3FcA-unsplash.jpg&w=640'),
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
          'Sony MX300 Wireless ANC Headphones',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '\$100.00',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}