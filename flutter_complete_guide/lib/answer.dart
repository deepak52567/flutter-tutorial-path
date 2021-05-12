import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function clickHandler;
  final String answerText;

  Answer(this.clickHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
        ),
        child: Text(this.answerText),
        onPressed: clickHandler,
        // style: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all(Colors.red)
        // ),
      ),
    );
  }
}
