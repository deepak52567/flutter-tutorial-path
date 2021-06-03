import 'package:flutter/material.dart';
import 'package:meals_app/screens/bookmarks_screen.dart';
import 'package:meals_app/screens/categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    // For top tabbed navigation bar
    // Automatically detects the content screen based on index position
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            enableFeedback: true,
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.collections_bookmark),
                text: 'Bookmarks',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            BookmarksScreen(),
          ],
        ),
      ),
    );
  }
}
