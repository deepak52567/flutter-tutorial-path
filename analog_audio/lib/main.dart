import 'package:analog_audio/screens/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Newer version of flutter, it ensures Orientations features executed
  WidgetsFlutterBinding.ensureInitialized();
  // Control device orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analog Audio',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
        )
      ),
      home: AuthScreen(),
    );
  }
}
