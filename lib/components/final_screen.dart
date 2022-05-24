import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/score.dart' as score_model;
import 'package:quiz_app/pages/score.dart';

class FinalScreen extends StatelessWidget {
  int score;
  VoidCallback onRestartPressed;

  FinalScreen({Key? key, required this.score, required this.onRestartPressed})
      : super(key: key);

  String? playerName = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'Quiz Completed !',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Image.asset(
          'assets/images/success.png',
          height: 250,
        ),
        const SizedBox(height: 30),
        Text(
          playerName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 15),
        Text(score.toString(), style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        if (score_model.Score.getHighestScore() != null &&
            score_model.Score.getHighestScore()!['playerName'] ==
                (FirebaseAuth.instance.currentUser!.isAnonymous
                    ? FirebaseAuth.instance.currentUser?.uid
                    : FirebaseAuth.instance.currentUser?.email) &&
            score_model.Score.getHighestScore()!['score'] == score)
          const Text('You Got Highest Score !!!'),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onRestartPressed,
            child: const Text('Restart Quiz'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Score()),
              );
            },
            child: const Text('Score List'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Main Menu'),
          ),
        )
      ],
    );
  }
}
