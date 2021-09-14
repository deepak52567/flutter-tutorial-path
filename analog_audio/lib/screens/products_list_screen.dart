import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/auth.dart';
import 'package:analog_audio/providers/products.dart';
import 'package:analog_audio/widgets/custom_icon_button.dart';
import 'package:analog_audio/widgets/custom_sliver_app_bar.dart';
import 'package:analog_audio/widgets/product_thumb_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductsListScreen extends StatelessWidget {
  static const routeName = '/products-listing';

  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final type = ModalRoute.of(context)?.settings.arguments as ProductType;
    final productsData = Provider.of<Products>(context);
    final products = type == ProductType.Headphones
        ? productsData.headphoneProducts
        : productsData.accessoriesProducts;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            flexibleSpaceData: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back_ios_rounded,
                  type: ButtonStyleType.Filled,
                ),
                Text(
                  EnumToString.convertToString(type),
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomIconButton(
                  onPressed: () {},
                  icon: Icons.search_outlined,
                  type: ButtonStyleType.Stroked,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1,
                  mainAxisExtent: 200),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductThumbView(
                    product: products[index],
                    dense: true,
                  );
                },
                childCount: products.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
