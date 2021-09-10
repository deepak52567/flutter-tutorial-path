import 'package:analog_audio/providers/auth.dart';
import 'package:analog_audio/providers/products.dart';
import 'package:analog_audio/screens/auth_screen.dart';
import 'package:analog_audio/screens/products_overview_screen.dart';
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
  static const MaterialColor kPrimaryColor = const MaterialColor(
    0xFF000000,
    const <int, Color>{
      50: const Color(0xFF000000),
      100: const Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: const Color(0xFF000000),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (BuildContext ctx, Auth auth, Products? products) => Products(
            auth.userId != null ? auth.userId! : '',
            auth.token != null ? auth.token! : '',
            products!.items != null ? products.items : [],
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          title: 'Analog Audio',
          theme: ThemeData(
            primarySwatch: kPrimaryColor,
            accentColor: Colors.teal.shade300,
            fontFamily: 'Lato',
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.teal.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.teal.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.teal.shade300.withOpacity(0.08),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline4: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor.withOpacity(0.8),
                  ),
                  headline5: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor.withOpacity(0.8),
                  ),
                  headline6: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w900,
                    color: kPrimaryColor.withOpacity(0.8),
                    fontSize: 15,
                  ),
                  bodyText2: TextStyle(
                    fontFamily: 'Lato',
                    color: kPrimaryColor.withOpacity(0.4),
                  ),
                ),
          ),
          home: authData.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
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
