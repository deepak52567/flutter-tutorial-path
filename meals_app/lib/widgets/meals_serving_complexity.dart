import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsServingComplexity extends StatelessWidget {

  final int duration;
  final Complexity complexity;

  const MealsServingComplexity(
      {required this.duration, required this.complexity});

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      (duration <= 1
              ? '${duration.toString()} Min'
              : '${duration.toString()} Mins') +
          ' | ' +
          complexityText,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
