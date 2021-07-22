import 'package:analog_audio/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Logout'),
        onPressed: () {
          Provider.of<Auth>(context, listen: false).logout();
        },
      ),
    );
  }
}
