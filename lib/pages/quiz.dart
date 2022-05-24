import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/answer.dart';
import 'package:quiz_app/components/final_screen.dart';
import 'package:quiz_app/components/question.dart';
import 'package:quiz_app/models/jawaban.dart';
import 'package:quiz_app/models/pertanyaan.dart';
import 'package:quiz_app/models/score.dart';
import 'package:quiz_app/models/user.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Pertanyaan> _questionsList = [
    Pertanyaan(
      'Siapakah Char Paling Wangy di Genshin Impact ?',
      [Jawaban('Amber', 5), Jawaban('Ganyu', 10), Jawaban('Keqing', 20)],
    ),
    Pertanyaan(
      'Char paling waifuable ?',
      [
        Jawaban('Violet', 20),
        Jawaban('Tsukasa', 40),
        Jawaban('Chizuru', 40),
        Jawaban('Pico', 0)
      ],
    ),
    Pertanyaan(
      'Cicak cicak apa yang mati di bulan april ?',
      [
        Jawaban('Kaori', 50),
        Jawaban('Cicak Cicak di Dinding', 0),
        Jawaban('Cicak Arab', 0)
      ],
    ),
    Pertanyaan(
      'Apa yang dilakukan programmer di hari raya ?',
      [
        Jawaban('Ngoding', 50),
        Jawaban('Ngoding', 50),
        Jawaban('dan Ngoding', 50)
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _questionsList.shuffle();
  }

  void answer(int answerIndex) {
    setState(() {
      score += _questionsList[currentQuestionIndex].jawaban[answerIndex].score;
      if (currentQuestionIndex == _questionsList.length - 1) {
        Score.scores = {
          'playerName': FirebaseAuth.instance.currentUser!.isAnonymous
              ? FirebaseAuth.instance.currentUser!.uid
              : FirebaseAuth.instance.currentUser?.email,
          'score': score,
          'dateTime': DateTime.now()
        };
      }
      currentQuestionIndex++;
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      _questionsList.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            if (currentQuestionIndex < _questionsList.length)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Pertanyaan ${currentQuestionIndex + 1} / ${_questionsList.length}'),
                  const SizedBox(height: 20),
                  Question(
                    question: _questionsList[currentQuestionIndex].pertanyaan,
                  ),
                  const SizedBox(height: 25),
                  ...List.generate(
                    _questionsList[currentQuestionIndex].jawaban.length,
                    (index) => Answer(
                      answer: _questionsList[currentQuestionIndex]
                          .jawaban[index]
                          .jawaban,
                      index: index,
                      onAnswer: answer,
                    ),
                  )
                ],
              )
            else
              FinalScreen(
                score: score,
                onRestartPressed: restartQuiz,
              )
          ],
        ),
      ),
    );
  }
}
