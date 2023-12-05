import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/BusinessAccount/finishProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Business Accounts Requests")
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          if (snapshot.data!['approvalStatus'] == "waiting" &&
              snapshot.data!['profile_finish'] == "unfinished") {
            waiting = true;
          } else if (snapshot.data!['approvalStatus'] == "approved" &&
              snapshot.data!['profile_finish'] == "unfinished") {
            waiting = false;
          }
        } else {
          return Text("");
        }
        return waiting!
            ? Container(
                child: const Padding(
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
              ))
            : const FinishProPage();
      },
    )

        /*   Container(
          child: const Padding(
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
      )), */
        );
  }
}
