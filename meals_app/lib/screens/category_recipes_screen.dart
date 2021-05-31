import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/widgets/meals_horizontal_list.dart';

class CategoryRecipesScreen extends StatelessWidget {
  static const routeName = '/category-recipes';

  @override
  Widget build(BuildContext context) {
    // To get route arguments
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryID = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryID))
        .toList();

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                'Trending Recipes',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            MealsHorizontalList(
              categoryMeals: categoryMeals,
              whiteSpace: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
