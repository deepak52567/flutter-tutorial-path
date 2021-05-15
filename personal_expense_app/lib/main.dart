import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/new_transaction.dart';
import 'package:personal_expense_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyPersonalExpense());

class MyPersonalExpense extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  // Can also work in stateless widget
  @override
  _MyPersonalExpenseState createState() => _MyPersonalExpenseState();
}

class _MyPersonalExpenseState extends State<MyPersonalExpense> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 1500, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Chips', amount: 600, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Printed Shirts', amount: 500, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Personal Expense'),
            actions: <Widget>[
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context),
                ),
              )
            ],
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
                TransactionList(_userTransactions),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          )),
    );
  }
}
