import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // Sets a fixed string which can be used over the other widget
  static const routeName = '/category-meals';

  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To get route arguments
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryID = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final categoryImage = routeArgs['bgImage'];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                decoration: BoxDecoration(),
                child: Text(categoryTitle!),
              ),
              stretchModes: [StretchMode.blurBackground],
              background: Image.asset(
                'assets/images/categories/${categoryImage}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
