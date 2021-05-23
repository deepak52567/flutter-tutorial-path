// Always put dar imports on top
import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    // final textScaling = mediaQuery.textScaleFactor;
    // IOS:Due to cupertino limited functionality, we will be using MaterialApp instead CupertinoApp for now
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        // Overrides all color style in other objects and can be used to change global styles as well
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        errorColor: Colors.red,
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

// use 'with' key to use a Mixin in the class. Here using WidgetsBindingObserver mixin
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];

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

  @override
  void initState() {
    // 'this' needs to have a didChangeAppLifecycleState() state in it before calling it
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // This method is called whenever the lifeCycle state changes
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    // Removing listeners to avoid memory leaks
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // AppBar builder method
  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expense',
            ),
            trailing: Row(
              // IOS
              // By default, row expands fully.
              // Using this will shrink as its item in it and title will not go out
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
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
  }

  // Builder method
  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidgetList) {
    return [
      Row(
        children: <Widget>[
          Text(
            "Show Chat",
            style: Theme.of(context).textTheme.headline6,
          ),
          // Adaptive means this switch will change its UI based on the OS
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
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
              height:
                  (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
              child: Chart(_recentTransactions),
            )
          : txWidgetList
    ];
  }

  // Builder method
  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txWidgetList) {
    return [
      Container(
        // Use media query to get device data and manipulate the UI part with it
        height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.3,
        child: Chart(_recentTransactions),
      ),
      txWidgetList
    ];
  }

  // CONTEXT is the element is the element tree which contains meta info about the widget and its location
  // Gives kind direct communication channel between widgets

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    // Add PreferredSizeWidget type to tell dart its type and method. To prevent errors
    final PreferredSizeWidget appBar = _buildAppBar();

    final txWidgetList = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    // IOS:SafeArea to bound the widget into usable area excluding the reserved ares. i.e appBar etc.
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // Main Axis y and Cross Axis is x
          // mainAxisAlignment: MainAxisAlignment.start,
          // Instead of child width, we can set stretch to take full width
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txWidgetList,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txWidgetList,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: null,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
