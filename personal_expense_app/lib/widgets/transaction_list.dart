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
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                // Container takes only one child widget
                // Rich styling and alignments options
                // Perfect for custom styling and all
                Container(
                  child: Text(
                    '\$${transactions[index].amount}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.green),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1)),
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
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
