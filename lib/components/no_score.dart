import 'package:flutter/material.dart';

class NoScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/images/astronaut.png',
        ),
        const Text(
          'Masih banyak ruang kosong disini, mari kita ciptakan yang baru !',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
