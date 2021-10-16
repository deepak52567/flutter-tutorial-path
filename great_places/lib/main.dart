import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GreatPlacesApp());
}

class GreatPlacesApp extends StatelessWidget {
  const GreatPlacesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
