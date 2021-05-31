import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class MealsHorizontalList extends StatelessWidget {
  const MealsHorizontalList({
    required this.categoryMeals,
    required this.whiteSpace,
    Key? key,
  }) : super(key: key);

  final List<Meal> categoryMeals;
  final double whiteSpace;

  void selectRecipe(BuildContext ctx, String id, String title, String bgImage) {
    // Navigator is a class which helps to navigate between screen and needs to be connected with context
    // Navigator.of(ctx).push(MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryMealsScreen(id, title);
    //   },
    // ));
    // Named Routes
    Timer(Duration(milliseconds: 100), () {
      Navigator.pushNamed(
        ctx,
        CategoryMealsScreen.routeName,
        arguments: {
          'id': id,
          'title': title,
          'bgImage': bgImage,
        },
      );
    });
  }

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
          return Container(
            height: double.infinity,
            width: (categoryMeals.length - 1) == index
                ? (MediaQuery.of(context).size.width * 0.6 + whiteSpace)
                : MediaQuery.of(context).size.width * 0.6,
            child: Stack(
              children: [
                Container(
                  margin: (categoryMeals.length - 1) == index
                      ? EdgeInsets.only(right: whiteSpace, left: whiteSpace)
                      : EdgeInsets.only(left: whiteSpace),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(categoryMeals[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 30,
                  right: (categoryMeals.length - 1) == index
                      ? (10 + whiteSpace)
                      : 10,
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
                                  Text(
                                    categoryMeals[index].title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categoryMeals[index].duration <= 1
                                        ? '${categoryMeals[index].duration.toString()} Min'
                                        : '${categoryMeals[index].duration.toString()} Mins',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    color: Theme.of(context).primaryColor,
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
                  right: (categoryMeals.length - 1) == index ? whiteSpace : 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => selectRecipe(
                        context,
                        categoryMeals[index].id,
                        categoryMeals[index].title,
                        categoryMeals[index].imageUrl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
