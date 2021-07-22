import 'package:analog_audio/providers/auth.dart';
import 'package:analog_audio/screens/auth_screen.dart';
import 'package:analog_audio/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          title: 'Analog Audio',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
              )),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  builder: (ctx, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? Center(child: Text('Loading...'))
                          : AuthScreen(),
                ),
        ),
      ),
    );
  }
}
