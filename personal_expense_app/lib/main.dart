import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/chart.dart';
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
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 1500, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New Chips', amount: 600, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Printed Shirts', amount: 500, date: DateTime.now()),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
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

  void _deleteTransaction(String transactionId) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == transactionId);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        // Overrides all color style in other objects and can be used to change global styles as well
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        fontFamily: 'QuickSand',
        // Creating a default setting for textTheme that can be used over the app
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.red),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Personal Expense',
            ),
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
                Chart(_recentTransactions),
                TransactionList(_userTransactions, _deleteTransaction),
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
