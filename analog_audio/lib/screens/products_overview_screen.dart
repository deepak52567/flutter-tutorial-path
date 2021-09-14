import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/products.dart';
import 'package:analog_audio/screens/products_list_screen.dart';
import 'package:analog_audio/widgets/custom_icon_button.dart';
import 'package:analog_audio/widgets/custom_sliver_app_bar.dart';
import 'package:analog_audio/widgets/products_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<Widget> getMainHeader(BuildContext context) {
    return [
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
    ];
  }

  List<Widget> renderProducts() {
    return [
      ProductHorizontalList(
        listTitle: 'Headphones',
        prdtType: ProductType.Headphones,
        showAll: () {
          Navigator.of(context).pushNamed(ProductsListScreen.routeName,
              arguments: ProductType.Headphones);
        },
      ),
      SizedBox(
        height: 20,
      ),
      ProductHorizontalList(
        listTitle: 'Accessories',
        prdtType: ProductType.Accessories,
        showAll: () {
          Navigator.of(context).pushNamed(ProductsListScreen.routeName,
              arguments: ProductType.Accessories);
        },
      ),
      SizedBox(
        height: 20,
      ),
    ].toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  flexibleSpaceData: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        onPressed: () {},
                        icon: Icons.menu_open_sharp,
                        type: ButtonStyleType.Filled,
                      ),
                      Row(
                        children: [
                          CustomIconButton(
                            onPressed: () {},
                            icon: Icons.search_outlined,
                            type: ButtonStyleType.Stroked,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomIconButton(
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .logout();
                            },
                            icon: Icons.logout,
                            type: ButtonStyleType.Stroked,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ...getMainHeader(context).toList(),
                    SizedBox(
                      height: 40,
                    ),
                    ...renderProducts()
                  ]),
                )
              ],
            ),
    );
  }
}
