import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_horizontal_list.dart';
import 'package:meals_app/widgets/meals_searchbar.dart';

class CategoryRecipesScreen extends StatefulWidget {
  static const routeName = '/category-recipes';

  @override
  _CategoryRecipesScreenState createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  late String? categoryID;
  late String? categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // To get route arguments
    final Map<String, String> routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryID = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryID))
        .toList();
    super.didChangeDependencies();
  }

  void _removeMeal(mealID) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: MealsSearchBar(),
            ),
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
              removeItem: _removeMeal,
            ),
          ],
        ),
      ),
    );
  }
}
