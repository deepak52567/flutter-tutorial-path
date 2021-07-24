import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        onPressed: () {},
                        icon: Icons.keyboard_arrow_left_outlined,
                        type: ButtonStyleType.Filled,
                      ),
                      CustomIconButton(
                        onPressed: () {},
                        icon: Icons.search_outlined,
                        type: ButtonStyleType.Stroked,
                      )
                    ],
                  ),
                  padding:
                  EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analog Audio',
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Audio Shop on Green Park, Delhi',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'This shop offers both products and services',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
