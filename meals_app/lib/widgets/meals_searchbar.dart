import 'package:flutter/material.dart';

class MealsSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.teal.withOpacity(0.05),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Meals',
          suffixIcon: Icon(Icons.search, color: Colors.teal,),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent
        ),
      ),
    );
  }
}
