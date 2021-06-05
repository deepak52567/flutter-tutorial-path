import 'package:flutter/material.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_recipes_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() {
  runApp(MealsApp());
}

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _bookmarkedMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleBookmark(String mealID) {
    final existingIndex =
        _bookmarkedMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _bookmarkedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _bookmarkedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  bool _isMealBookmarked(String mealID) {
    return _bookmarkedMeals.any((meal) => meal.id == mealID);
  }

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
        '/': (ctx) => TabsScreen(_bookmarkedMeals, _toggleBookmark, _isMealBookmarked),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleBookmark, _isMealBookmarked),
        CategoryRecipesScreen.routeName: (ctx) =>
            CategoryRecipesScreen(_availableMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
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
