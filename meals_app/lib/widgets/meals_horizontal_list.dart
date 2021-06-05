import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import 'meals_recipe_item.dart';

class MealsHorizontalList extends StatelessWidget {
  final List<Meal> categoryMeals;
  final double whiteSpace;
  final Function removeItem;

  const MealsHorizontalList({
    required this.categoryMeals,
    required this.whiteSpace,
    required this.removeItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        itemCount: categoryMeals.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          print(categoryMeals.length);
          print(index);
          return MealsRecipeItem(
            categoriesLength: categoryMeals.length,
            index: index,
            whiteSpace: whiteSpace,
            categoryMeal: categoryMeals[index],
            removeItem: removeItem,
          );
        },
      ),
    );
  }
}
