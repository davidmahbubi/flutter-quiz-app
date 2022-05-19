import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  var onAnswer;
  String answer;
  int index;

  Answer(
      {Key? key,
      required this.index,
      required this.answer,
      required this.onAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onAnswer(index);
        },
        child: Text(answer),
      ),
    );
  }
}
