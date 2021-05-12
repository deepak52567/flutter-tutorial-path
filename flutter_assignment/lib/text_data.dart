import 'package:flutter/material.dart';

class TextData extends StatelessWidget {
  final String textData;

  TextData(this.textData);

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
