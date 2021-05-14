import 'package:flutter/foundation.dart';

class Transaction {
  // final! Should never change after runtime assignment
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
