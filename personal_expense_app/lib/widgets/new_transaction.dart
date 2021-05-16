import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    // Minor validation
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    // widget gives access to addTx property from extended class
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    // using Navigator to close bottomsheet using pop()
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // Keyboard type method
              keyboardType: TextInputType.number,
              // Kind of convention is show _ as intentional unused argument
              onSubmitted: (_) => submitData,
              // onChanged: (value) => amountInput = value,
            ),
            Row(
              children: <Widget>[
                Text(
                  'No Date Chosen!',
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              // style: ElevatedButton.styleFrom(
              //   textStyle: TextStyle(color: Theme.of(context).textTheme.button.color),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
