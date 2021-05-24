import 'package:flutter/material.dart';
import 'package:meals_app/category_item.dart';

import './models/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals Recipe'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: ThemeData.light().primaryIconTheme.color,
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
        children: DUMMY_CATEGORIES
            .map(
              (catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
                key: ValueKey(catData.id),
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          // 3/2 basically represents value based on 200
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
