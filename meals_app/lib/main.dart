import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_recipes_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

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
          actionsIconTheme:
              IconThemeData(color: Theme.of(context).primaryIconTheme.color),
          backgroundColor: Color.fromRGBO(250, 255, 255, 1),
          elevation: 0,
        ),
      ),
      // Initial route set to /
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        CategoryRecipesScreen.routeName: (ctx) => CategoryRecipesScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
      },
      // onGenerateRoute is your fallback/ option to have more control about the
      // creation + configuration of routing actions (= MaterialPageRoute that then loads a specific screen widget).
      //Gives some information about route, i.e args and routes
      // onGenerateRoute: (setting) {
      //   print(setting.arguments);
      //   print(setting.name);
      //   // Also use conditional approach using name or arguments
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      // Handles unknown route handling  i.e 404 or Homescreen or Auth handling too
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
    );
  }
}
