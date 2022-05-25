import 'package:flutter/material.dart';
import 'package:quiz_app/components/score_card.dart';

class ScoreList extends StatelessWidget {
  final List<Map<String, dynamic>> scoreLists;

  ScoreList(this.scoreLists);

  @override
  Widget build(BuildContext context) {
    return scoreLists.isNotEmpty
        ? ScrollableScoreList(scoreLists)
        : BlankScoreList();
  }
}

class ScrollableScoreList extends StatelessWidget {
  final List<Map<String, dynamic>> scoresList;

  ScrollableScoreList(this.scoresList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: scoresList.length,
      itemBuilder: (BuildContext context, int index) {
        return ScoreCard(
          index: index,
          playerName: scoresList[index]['playerName'],
          score: scoresList[index]['score'],
          dateTime: scoresList[index]['dateTime'],
        );
      },
    );
  }
}

class BlankScoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/astronaut.png'),
                      const Text('Tidak Ada Riwayat Bermain'),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
