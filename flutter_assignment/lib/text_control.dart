import 'package:flutter/material.dart';
import 'package:flutter_assignment/text_data.dart';

class TextConrol extends StatefulWidget {
  @override
  _TextConrolState createState() => _TextConrolState();
}

class _TextConrolState extends State<TextConrol> {
  String _text = 'Some Text';

  void _updateText() {
    setState(() {
      _text = 'Text updated';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextData(_text),
          ElevatedButton(onPressed: _updateText, child: Text('Change Text'))
        ],
      ),
    );
  }
}
