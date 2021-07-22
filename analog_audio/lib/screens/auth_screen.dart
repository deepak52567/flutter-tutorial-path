import 'package:analog_audio/widgets/auth_card.dart';
import 'package:analog_audio/widgets/auth_mode_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        alignment: Alignment.centerRight,
                        child: AuthModeToggle(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/dji_logo.png',
                          width: deviceSize.width > 600
                              ? deviceSize.width * 0.2
                              : deviceSize.width * 0.25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Analog Audio',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
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
