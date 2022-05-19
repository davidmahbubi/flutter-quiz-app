import 'package:flutter/material.dart';
import 'package:quiz_app/components/answer.dart';
import 'package:quiz_app/components/final_screen.dart';
import 'package:quiz_app/components/question.dart';
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
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "Siapakah Char Paling Wangy di Genshin Impact ?",
      "answers": ["Amber", "Keqing", "Ganyu"],
      "answerIndex": 2
    },
    {
      "question": "Bahasa Pemrograman Paling Buriq",
      "answers": ["JavaScript", "C++", "Pi Eich Pi"],
      "answerIndex": 2
    },
    {
      "question":
          "Speed Saya Lambat, Berantakan dan Berukuran Besar, Tapi Saya Populer, Siapakah Saya ?",
      "answers": ["React", "Vue", "Angular"],
      "answerIndex": 0
    },
    {
      "question": "Suka Ngoding Ga ?",
      "answers": [
        "Suka sih, tapi ga ampe baper",
        "Suka banget dong",
        "Suka - suka ku lah :)"
      ],
      "answerIndex": 1
    },
    {
      "question": "Bahasa Pemrograman Buat Anak Balita",
      "answers": ["C++", "Japa", "JapaSekrip"],
      "answerIndex": 2
    },
  ];

  @override
  void initState() {
    super.initState();
    _questions.shuffle();
  }

  void answer(int answerIndex) {
    setState(() {
      if (answerIndex == _questions[currentQuestionIndex]['answerIndex']) {
        score += 10;
      }
      if (currentQuestionIndex == _questions.length - 1) {
        Score.scores = {
          'playerName': User.name,
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
      _questions.shuffle();
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
            if (currentQuestionIndex < _questions.length)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Pertanyaan ${currentQuestionIndex + 1} / ${_questions.length}'),
                  const SizedBox(height: 20),
                  Question(
                    question: _questions[currentQuestionIndex]['question'],
                  ),
                  const SizedBox(height: 25),
                  ...List.generate(
                      _questions[currentQuestionIndex]['answers'].length,
                      (index) => Answer(
                            answer: _questions[currentQuestionIndex]['answers']
                                [index],
                            index: index,
                            onAnswer: answer,
                          ))
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
