import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  // Properties of object cant be changed after it has been assigned
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.teal,
  });
}
