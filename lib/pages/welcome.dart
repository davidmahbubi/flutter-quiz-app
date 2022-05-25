import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/homepage_bottom_control.dart';
import 'package:quiz_app/components/score_list.dart';
import 'package:quiz_app/components/user_info_card.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/pages/score.dart';
import 'package:quiz_app/models/score.dart' as scoreModel;

class Welcome extends StatefulWidget {
  User? user;

  Welcome({Key? key, this.user}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Map<String, dynamic>> currentUserScores =
      scoreModel.Score.getCurrentUserScores();
  int userPoint = 0;

  @override
  Widget build(BuildContext context) {
    refreshScoreList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            UserInfoCard(totalPoint: userPoint, user: widget.user),
            Expanded(child: ScoreList(currentUserScores)),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: HomepageBottomControl(onScoreList: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Score(),
                  ),
                );
              }, onPlay: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Quiz(),
                      ),
                    )
                    .then((value) => setState(() {}));
              }),
            )
          ],
        ),
      ),
    );
  }

  void refreshScoreList() {
    currentUserScores = scoreModel.Score.getCurrentUserScores();
    userPoint = 0;
    if (currentUserScores.length > 0) {
      currentUserScores.forEach((element) {
        userPoint += element['score'] as int;
      });
    }
  }
}
