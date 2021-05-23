import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_expense_app/models/transaction.dart';
import 'package:personal_expense_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  // Text(
                  //   'No transaction added yet!',
                  //   style: Theme.of(context).textTheme.headline6,
                  // ),
                  // Can be also used as adding space between items
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/page-empty-placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        // : ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       return TransactionItem(
        //           transaction: transactions[index], deleteTx: deleteTx);
        //     },
        //     itemCount: transactions.length,
        //   );
        // Changing it use key
        : ListView(
            children: [
              ...transactions
                  .map(
                    (tx) => TransactionItem(
                        // ValueKey creates a unique id based on transaction id and widget type which will be unique to every element
                        // Overall it helps flutter to identify each element separately
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx),
                  )
                  .toList()
            ],
          );
  }
}
