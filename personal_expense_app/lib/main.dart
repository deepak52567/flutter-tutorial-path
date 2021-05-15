import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/user_transaction.dart';

void main() => runApp(MyPeronsalExpense());

class MyPeronsalExpense extends StatelessWidget {
  // String titleInput;
  // String amountInput;

  // Can also work in stateless widget
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expense'),
        ),
        body: SingleChildScrollView(
          child: Column(
            // Main Axis y and Cross Axis is x
            // mainAxisAlignment: MainAxisAlignment.start,
            // Instead of child width, we can set stretch to take full width
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Card(
                  child: Text('Chart'),
                  elevation: 5,
                  color: Colors.white,
                ),
              ),
              UserTransaction(),
            ],
          ),
        ),
      ),
    );
  }
}
