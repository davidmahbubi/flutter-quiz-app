import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/auth/signup.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/service/FirebaseService.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final TextEditingController _playerNameController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              const Text(
                'Selamat Datang di Quiz App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/puzzle.png',
                height: 270,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 13),
                      TextField(
                        controller: _email,
                        decoration: const InputDecoration(hintText: 'E-Mail'),
                      ),
                      const SizedBox(height: 13),
                      TextField(
                        controller: _password,
                        obscureText: isObsecure,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: Icon(
                                !isObsecure ? Icons.lock : Icons.lock_open),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseService.signInEmailPassword(
                                _email.text, _password.text);
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2.5),
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Signup(),
                                      ),
                                    );
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.5),
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Anonymous Login'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
