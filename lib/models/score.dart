import 'package:firebase_auth/firebase_auth.dart';

class Score {
  static final List<Map<String, dynamic>> _scores = [];

  static set scores(Map<String, dynamic> score) {
    _scores.add(score);
  }

  static List<Map<String, dynamic>> getSortedScores() {
    _scores.sort((Map<String, dynamic> val1, Map<String, dynamic> val2) {
      return val2['score'].compareTo(val1['score']);
    });
    return _scores;
  }

  static Map<String, dynamic>? getHighestScore() {
    return getSortedScores().isNotEmpty ? getSortedScores()[0] : null;
  }

  static List<Map<String, dynamic>> getCurrentUserScores() {
    return getSortedScores()
        .where((element) =>
            element['playerName'] ==
            (FirebaseAuth.instance.currentUser!.isAnonymous
                ? FirebaseAuth.instance.currentUser!.uid
                : FirebaseAuth.instance.currentUser!.email))
        .toList();
  }

  static void clearScoreList() {
    _scores.removeRange(0, _scores.length);
  }
}
