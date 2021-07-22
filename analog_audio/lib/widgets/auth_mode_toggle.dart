import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthModeToggle extends StatefulWidget {
  const AuthModeToggle({
    Key? key,
  }) : super(key: key);

  @override
  _AuthModeToggleState createState() => _AuthModeToggleState();
}

class _AuthModeToggleState extends State<AuthModeToggle> {
  @override
  Widget build(BuildContext context) {
    final AuthMode existingAuthMode =
        Provider.of<Auth>(context, listen: true).authMode;
    return TextButton(
      child: existingAuthMode == AuthMode.Signup
          ? Text('Already a user?')
          : Text('Create new user?'),
      onPressed: () {
        try {
          Provider.of<Auth>(context, listen: false).changeAuthState =
          existingAuthMode == AuthMode.Login
              ? AuthMode.Signup
              : AuthMode.Login;
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text('Application Error')));
        }
      },
    );
  }
}