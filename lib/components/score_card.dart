import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreCard extends StatelessWidget {
  int index;
  String playerName;
  DateTime dateTime;
  int score;

  ScoreCard(
      {Key? key,
      required this.index,
      required this.playerName,
      required this.score,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 14,
        ),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  playerName,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd/MM/yyyy | HH:mm:ss').format(dateTime),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(score.toString()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
