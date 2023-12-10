import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/BusinessAccount/finishProfilePage.dart';
import 'package:final_project/Pages/IndividualAccount/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

bool? waiting;

final FirebaseAuth _auth = FirebaseAuth.instance;

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: DrawerPage(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image(
              image: AssetImage('assets/waiting.gif'),
              width: 350,
              height: 400,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Your account is being processed by admin, please wait until approved",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
