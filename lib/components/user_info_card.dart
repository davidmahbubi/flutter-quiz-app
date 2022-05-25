import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:quiz_app/service/FirebaseService.dart';

class UserInfoCard extends StatelessWidget {
  final int totalPoint;
  final User? user;

  UserInfoCard({required this.totalPoint, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Initicon(
              size: 60,
              text: user!.isAnonymous ? user!.uid : user!.email,
              backgroundColor: Colors.red,
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user!.isAnonymous ? user!.uid : user!.email.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('$totalPoint Points')
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
    );
  }
}
