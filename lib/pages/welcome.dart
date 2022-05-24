import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      const Initicon(
                        size: 60,
                        text: 'David Mahbubi',
                        backgroundColor: Colors.red,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'David Mahbubi',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('50 Points')
                        ],
                      ),
                      Expanded(
                          child: TextButton(
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {},
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('Sign Out'),
                        ),
                      ))
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

  // Column(
  //     children: [
  //       ElevatedButton.icon(
  //         icon: const Icon(Icons.play_arrow),
  //         label: const Text('Start Quiz'),
  //         onPressed: () async {
  //           // _playerNameController.text = '';
  //           // getPlayerName(context);
  //         },
  //       ),
  //       OutlinedButton.icon(
  //         icon: const Icon(Icons.star),
  //         label: const Text('Score List'),
  //         onPressed: () {
  //           // Navigator.of(context).push(
  //           //   MaterialPageRoute(
  //           //     builder: ((BuildContext context) => Score()),
  //           //   ),
  //           // );
  //         },
  //       ),
  //     ],
  //   );
}
