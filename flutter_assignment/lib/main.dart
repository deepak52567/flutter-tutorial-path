import 'package:flutter/material.dart';
import 'package:flutter_assignment/text_control.dart';

void main() => runApp(FlutterAssignment());

class FlutterAssignment extends StatefulWidget {
  @override
  _FlutterAssignmentState createState() => _FlutterAssignmentState();
}

class _FlutterAssignmentState extends State<FlutterAssignment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Flutter Assigment 1',
            ),
          ),
          body: TextConrol()),
    );
  }
}
