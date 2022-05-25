import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/pages/score.dart';

class HomepageBottomControl extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onScoreList;

  HomepageBottomControl({required this.onPlay, required this.onScoreList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2.5),
            child: ElevatedButton(
              child: const Text('Play'),
              onPressed: onPlay,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2.5),
            child: OutlinedButton(
              child: const Text('Score List'),
              onPressed: onScoreList,
            ),
          ),
        ),
      ],
    );
  }
}
