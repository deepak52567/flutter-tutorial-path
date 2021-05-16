import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // ListView children [] is fine in case of fixed items in small range
      // ListView.builder constructor is used in case of unknown length of items to facilitate lazy loaded items
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                // Can be also used as adding space between items
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/page-empty-placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      // Container takes only one child widget
                      // Rich styling and alignments options
                      // Perfect for custom styling and all
                      Container(
                        child: Text(
                          // Show number until two decimal places
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            // Using global setting for app context
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            // Using global setting for app context
                            color: Theme.of(context).primaryColor, width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        // However, column/row takes multiple child widgets
                        // Always takes full width/height in column/row respectively
                        // Useful if widgets are multiple and needs to be next to each other
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            // Accessing global theme set on App main class
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            // Can put format in DateFormat('yyyy') parameter
                            // Or can choose pre-configuration in special constructors
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
