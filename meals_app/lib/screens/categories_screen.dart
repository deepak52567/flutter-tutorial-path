import 'package:flutter/material.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // When using inside a tabbed bar, no need to add scaffold as it already contained in that screen
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GridView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            children: DUMMY_CATEGORIES
                .map(
                  (catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                    catData.bgImage,
                    key: ValueKey(catData.id),
                  ),
                )
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              // 3/2 basically represents value based on 200
              childAspectRatio: 5 / 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
          ),
        ),
      ],
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Meals Recipe'),
    //     actions: [
    //       IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
    //     ],
    //     leading: IconButton(
    //       onPressed: () {},
    //       icon: Icon(Icons.account_circle),
    //       color: Theme.of(context).primaryColor,
    //     ),
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Expanded(
    //         child: GridView(
    //           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    //           children: DUMMY_CATEGORIES
    //               .map(
    //                 (catData) => CategoryItem(
    //                   catData.id,
    //                   catData.title,
    //                   catData.color,
    //                   catData.bgImage,
    //                   key: ValueKey(catData.id),
    //                 ),
    //               )
    //               .toList(),
    //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //             maxCrossAxisExtent: 200,
    //             // 3/2 basically represents value based on 200
    //             childAspectRatio: 5 / 4,
    //             crossAxisSpacing: 15,
    //             mainAxisSpacing: 15,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
