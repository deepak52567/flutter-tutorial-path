import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}


class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // no final bcz it will change
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    // Minor validation
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // widget gives access to addTx property from extended class
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    // using Navigator to close bottomsheet using pop()
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // Futures are classes which give us value in future for eg selected date, http response
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // IOS: Can use cupertinoTextField also
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
                // onChanged: (value) => titleInput = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                // Keyboard type method
                keyboardType: TextInputType.number,
                // Kind of convention is show _ as intentional unused argument
                onSubmitted: (_) => _submitData,
                // onChanged: (value) => amountInput = value,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker),
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
