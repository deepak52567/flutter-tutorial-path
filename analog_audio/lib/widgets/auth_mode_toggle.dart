import 'package:analog_audio/models/enums.dart';
import 'package:flutter/material.dart';

class AuthModeToggle extends StatelessWidget {
  final AuthMode authMode;
  final Function _toggleAuthMode;

  AuthModeToggle(
    this.authMode,
    this._toggleAuthMode, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: authMode == AuthMode.Signup
          ? Text('Already a user?')
          : Text('Create new user?'),
      onPressed: () => _toggleAuthMode(),
    );
  }
}
