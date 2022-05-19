import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/pages/score.dart';

void main(List<String> args) => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final TextEditingController _playerNameController = TextEditingController();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 100),
                      const Text(
                        'Selamat Datang di Quiz App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/images/puzzle.png',
                        height: 300,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Quiz'),
                        onPressed: () async {
                          _playerNameController.text = '';
                          getPlayerName(context);
                        },
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.star),
                        label: const Text('Score List'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((BuildContext context) => Score()),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text('© 2022 David Mahbubi'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPlayerName(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext bContext) {
        return AlertDialog(
          title: const Text('Masukkan Nama Anda'),
          content: TextField(
            controller: _playerNameController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = _playerNameController.text == ''
                    ? 'Anonymous'
                    : _playerNameController.text;
                User.name = name;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Quiz(),
                  ),
                );
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
}
