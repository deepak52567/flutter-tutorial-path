import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/bookmarks_screen.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/widgets/app_drawer.dart';

class TabsScreenModel {
  final String title;
  final Object page;
  final IconData pageIcon;

  const TabsScreenModel(
      {required this.title, required this.page, required this.pageIcon});
}

class TabsScreen extends StatefulWidget {
  final List<Meal> bookmarkedMeals;
  final void Function(String mealID) toggleBookmark;
  final bool Function(String mealID) isMealBookmarked;

  const TabsScreen(this.bookmarkedMeals, this.toggleBookmark, this.isMealBookmarked, {Key? key})
      : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<TabsScreenModel> _screens;
  int _selectedPageIndex = 0;

  @override
  initState() {
    // Shifted _screens assignment to initState to use widget instance
    _screens = [
      TabsScreenModel(
        title: 'Categories',
        page: CategoriesScreen(),
        pageIcon: Icons.category,
      ),
      TabsScreenModel(
        title: 'Bookmarks',
        page: BookmarksScreen(widget.bookmarkedMeals, widget.toggleBookmark, widget.isMealBookmarked),
        pageIcon: Icons.collections_bookmark,
      ),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // BOttom tabbed bar layout
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedPageIndex].title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Theme.of(context).primaryColor,
          ),
        ],
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.account_circle),
        //   color: Theme.of(context).primaryColor,
        // ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(_screens[0].pageIcon),
            label: _screens[0].title,
          ),
          BottomNavigationBarItem(
            icon: Icon(_screens[1].pageIcon),
            label: _screens[1].title,
          ),
        ],
        enableFeedback: true,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
      ),
      body: _screens[_selectedPageIndex].page as Widget,
    );

    // For top tabbed navigation bar
    // Automatically detects the content screen based on index position
    // return DefaultTabController(
    //   length: 2,
    //   // initialIndex: 0,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       bottom: TabBar(
    //         indicatorColor: Theme.of(context).accentColor,
    //         enableFeedback: true,
    //         labelColor: Theme.of(context).primaryColor,
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.collections_bookmark),
    //             text: 'Bookmarks',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[
    //         CategoriesScreen(),
    //         BookmarksScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
