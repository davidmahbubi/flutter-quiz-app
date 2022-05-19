import 'package:flutter/material.dart';
import 'package:quiz_app/components/no_score.dart';
import 'package:quiz_app/components/score_card.dart';
import 'package:quiz_app/models/score.dart' as score_model;

class Score extends StatefulWidget {
  const Score({Key? key}) : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  List<Map<String, dynamic>> scores = score_model.Score.getSortedScores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Hapus Score List ?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Batal')),
                        TextButton(
                            onPressed: () {
                              score_model.Score.clearScoreList();
                              setState(() {
                                scores = score_model.Score.getSortedScores();
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Konfirmasi')),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Text(
              'Score List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: scores.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: scores.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ScoreCard(
                          index: index,
                          playerName: scores[index]['playerName'],
                          score: scores[index]['score'],
                          dateTime: scores[index]['dateTime'],
                        );
                      },
                    )
                  : NoScore(),
            )
          ],
        ),
      ),
    );
  }
}
