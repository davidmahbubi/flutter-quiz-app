import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/wrapper.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/auth/siginin.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/service/FirebaseService.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: StreamProvider.value(
        value: FirebaseService.firebaseUserStream,
        initialData: null,
        child: const Wrapper(),
      ),
    );
  }
}
