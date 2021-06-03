import 'package:flutter/material.dart';
import 'package:meals_app/widgets/app_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Center(
        child: Text('Filters Scree'),
      ),
    );
  }
}
