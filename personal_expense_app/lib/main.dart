import 'package:flutter/material.dart';

void main() {
  runApp(MyPeronsalExpense());
}

class MyPeronsalExpense extends StatefulWidget {
  @override
  _MyPeronsalExpenseState createState() => _MyPeronsalExpenseState();
}

class _MyPeronsalExpenseState extends State<MyPeronsalExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
      ),
      body: Center(
        child: Text('Initial App'),
      ),
    );
  }
}
