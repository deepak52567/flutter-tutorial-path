import 'package:analog_audio/widgets/auth_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  width: deviceSize.width > 600
                      ? deviceSize.width * 0.2
                      : deviceSize.width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.color),
                        child: Image.asset(
                          'assets/images/dji_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Analog Audio',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: AuthCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
