import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/chart.dart';
import 'package:personal_expense_app/widgets/new_transaction.dart';
import 'package:personal_expense_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  // // Newer version of flutter, it ensures Orientations features executed
  // WidgetsFlutterBinding.ensureInitialized();
  // // Control device orientation
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyPersonalExpense());
}

class MyPersonalExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // textScaleFactor considers device font size. default is 1
    // final textScaling = MediaQuery.of(context).textScaleFactor;
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expense',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // Main Axis y and Cross Axis is x
          // mainAxisAlignment: MainAxisAlignment.start,
          // Instead of child width, we can set stretch to take full width
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Show Chat"),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            _showChart
                ? Container(
                    // Use media query to get device data and manipulate the UI part with it
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction),
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
