import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(
      BuildContext ctx, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.bodyText2,
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: ListTile(
              horizontalTitleGap: 0,
              title: Text(
                'Meals App',
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: Icon(Icons.fastfood),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildListTile(
            context,
            'Meals',
            Icons.restaurant,
            // () => Navigator.of(context).pushNamed('/'),
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _buildListTile(
            context,
            'Filters',
            Icons.filter_alt,
            // pushReplacementNamed replaces the existing stack of pages
            () => Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
