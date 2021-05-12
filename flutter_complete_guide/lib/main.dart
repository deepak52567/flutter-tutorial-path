import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  // Final is runtime constant value. Doesn't change at runtime
  // Const is never changes, its an compile time constant
  // questions can be var, and const for its values. So you cannot change the current values but can assign new values
  final _questions = const <Map<String, Object>>[
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 7},
        {'text': 'Blue', 'score': 5},
        {'text': 'Grey', 'score': 3}
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 8},
        {'text': 'Dog', 'score': 10},
        {'text': 'Cat', 'score': 5},
      ]
    },
    {
      'questionText': 'What\'s your favorite language?',
      'answers': [
        {'text': 'English', 'score': 10},
        {'text': 'Hindi', 'score': 6},
        {'text': 'Bengali', 'score': 5},
        {'text': 'Nepali', 'score': 3},
      ]
    },
  ];

  // questions = []. Doesn't work if questions is an const

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });
    if (_isQuestionEnded) {
      print('We have more questions');
    } else {
      print('No more questions!');
    }
  }

  bool get _isQuestionEnded {
    return _questionIndex < _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _isQuestionEnded
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
