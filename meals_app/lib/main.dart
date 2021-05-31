import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/category_recipes_screen.dart';

void main() {
  runApp(MealsApp());
}

class MealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals Recipe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepOrangeAccent,
        //bg Color
        canvasColor: Color.fromRGBO(250, 255, 255, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
        primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
          color: Colors.teal,
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
          actionsIconTheme: IconThemeData(
            color: Theme.of(context).primaryIconTheme.color
          ),
          backgroundColor: Color.fromRGBO(250, 255, 255, 1),
          elevation: 0,
        ),
      ),
      // Initial route set to /
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        CategoryRecipesScreen.routeName: (ctx) => CategoryRecipesScreen(),
      },
    );
  }
}
