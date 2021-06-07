import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/widgets/meals_serving_complexity.dart';

class MealsRecipeItem extends StatelessWidget {
  final num categoriesLength;
  final num index;
  final double whiteSpace;
  final Meal categoryMeal;
  final Function removeItem;
  final bool Function(String mealID) isMealBookmarked;

  MealsRecipeItem(
      {required this.categoriesLength,
      required this.index,
      required this.whiteSpace,
      required this.categoryMeal,
      required this.removeItem,
      required this.isMealBookmarked});

  void selectMeal(BuildContext ctx) {
    // Navigator is a class which helps to navigate between screen and needs to be connected with context
    // Navigator.of(ctx).push(MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryMealsScreen(id, title);
    //   },
    // ));
    // Named Routes
    // pushNamed return Future, which refers to future expected data from it. Kind of promise
    Navigator.of(ctx)
        .pushNamed(MealDetailScreen.routeName, arguments: categoryMeal.id)
        .then((value) {
      if (value != null) {
        removeItem(value);
      }
    });
  }

  String get affordableText {
    switch (categoryMeal.affordability) {
      case Affordability.Affordable:
        return '\$';
      case Affordability.Pricey:
        return '\$\$';
      case Affordability.Pricey:
        return '\$\$\$';
      default:
        return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: (categoriesLength - 1) == index
          ? (MediaQuery.of(context).size.width * 0.6 + whiteSpace)
          : MediaQuery.of(context).size.width * 0.6,
      child: Stack(
        children: [
          Container(
            margin: (categoriesLength - 1) == index
                ? EdgeInsets.only(right: whiteSpace, left: whiteSpace)
                : EdgeInsets.only(left: whiteSpace),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(categoryMeal.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: (categoriesLength - 1) == index ? (10 + whiteSpace) : 10,
            child: Text(
              affordableText,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 30,
            right: (categoriesLength - 1) == index ? (10 + whiteSpace) : 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 19.2,
                  sigmaX: 19.2,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User text in container to contain and user overflow and wrap property
                            Text(
                              categoryMeal.title,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            MealsServingComplexity(
                              duration: categoryMeal.duration,
                              complexity: categoryMeal.complexity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              isMealBookmarked(categoryMeal.id)
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: isMealBookmarked(categoryMeal.id)
                                  ? Theme.of(context).primaryIconTheme.color
                                  : Theme.of(context).accentIconTheme.color,
                              size: whiteSpace,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: whiteSpace,
            right: (categoriesLength - 1) == index ? whiteSpace : 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                onTap: () => selectMeal(
                  context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
