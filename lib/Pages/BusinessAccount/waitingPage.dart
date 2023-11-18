import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Your account is being processed by admin, please wait until approved",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          )),
    );
  }
}
