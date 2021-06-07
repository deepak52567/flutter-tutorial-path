import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class BookmarksScreen extends StatelessWidget {
  final List<Meal> bookmarkedMeals;
  final void Function(String mealID) toggleBookmark;
  final bool Function(String mealID) isMealBookmarked;

  const BookmarksScreen(
      this.bookmarkedMeals, this.toggleBookmark, this.isMealBookmarked,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bookmarkedMeals.isEmpty) {
      // No need of scaffold if using it inside tabbed layout
      return Center(
        child: Text('No meals bookmarked'),
      );
    } else {
      return ListView.builder(
        itemCount: bookmarkedMeals.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.of(context).pushNamed(
                MealDetailScreen.routeName,
                arguments: bookmarkedMeals[index].id),
            title: Text(bookmarkedMeals[index].title),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(bookmarkedMeals[index].imageUrl),
            ),
            trailing: Icon(Icons.arrow_forward_rounded),
          );
        },
      );
    }
  }
}
