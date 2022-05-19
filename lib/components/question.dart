import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String question;

  Question({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 25),
    );
  }
}
