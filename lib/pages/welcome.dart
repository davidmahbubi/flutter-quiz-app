import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/pages/score.dart';
import 'package:quiz_app/service/FirebaseService.dart';
import 'package:quiz_app/components/score_card.dart';
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
    currentUserScores = scoreModel.Score.getCurrentUserScores();
    userPoint = 0;
    if (currentUserScores.length > 0) {
      currentUserScores.forEach((element) {
        userPoint += element['score'] as int;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Initicon(
                      size: 60,
                      text: widget.user!.isAnonymous
                          ? widget.user!.uid
                          : widget.user!.email,
                      backgroundColor: Colors.red,
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.user!.isAnonymous
                                ? widget.user!.uid
                                : widget.user!.email.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('$userPoint Points')
                        ],
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        FirebaseService.signOut();
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text('Sign Out'),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            currentUserScores.length > 0
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: currentUserScores.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ScoreCard(
                          index: index,
                          playerName: currentUserScores[index]['playerName'],
                          score: currentUserScores[index]['score'],
                          dateTime: currentUserScores[index]['dateTime'],
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Container(
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
                                      Image.asset(
                                          'assets/images/astronaut.png'),
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
                    ),
                  ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.5),
                      child: ElevatedButton(
                        child: const Text('Play'),
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Quiz(),
                                ),
                              )
                              .then((value) => setState(() {}));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.5),
                      child: OutlinedButton(
                        child: const Text('Score List'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Score(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
