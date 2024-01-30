// Importing necessary Dart and Flutter packages
import 'package:final_project/Pages/BusinessAccount/BpPage.dart';
import 'package:final_project/Pages/BusinessAccount/RejectedPage.dart';
import 'package:final_project/Pages/BusinessAccount/finishProfilePage.dart';
import 'package:final_project/Pages/BusinessAccount/waitingPage.dart';
import 'package:final_project/Pages/IndividualAccount/getLocationPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../mainPage.dart';
import '../../LoginTab.dart';

// Defining a StatefulWidget class named AccountCheckPage
class AccountCheckPage extends StatefulWidget {
  const AccountCheckPage({super.key});

  @override
  State<AccountCheckPage> createState() => _AccountCheckPageState();
}

// Defining the State class _AccountCheckPageState
class _AccountCheckPageState extends State<AccountCheckPage> {
  @override
  void initState() {
    super.initState();
    // accountCheck(); // Uncomment this line if needed in the future
  }

  User? user;
  bool? exists;

  int index = 0;
  List<Widget> pagebuilder = [
    const LoginTab(),
    WaitingPage(),
    const FinishProPage(),
    const BpPage(),
    const mainPage(),
    const RejectedPage()
  ];

  // Building the UI based on the account check result
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: accountCheck(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // The asynchronous operations are complete
            return pagebuilder[snapshot.data ?? 0];
          } else {
            // The asynchronous operations are still in progress
            return const Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Image(
                      height: 300,
                      image: AssetImage('assets/landingpage.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 229, 143, 101)),
                  ),
                ],
              ),
            );
          }
        });
  }

  // Method to get the current user
  Future<User> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    return user;
  }

  // Method to check if the user has a certain role
  Future<bool> roleChecker(String? user) async {
    bool? exists;
    if (user != null) {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("Business Accounts Requests")
          .doc('${user}');
      DocumentSnapshot documentSnapshot = await documentReference.get();
      exists = documentSnapshot.exists;
    } else {
      exists == false; // Typo correction: use '=' instead of '=='
    }
    return exists!;
  }

  // Method to determine the appropriate page index based on user and role status
  Future<int> pageBuilder(String user, bool exists) async {
    int num = 1;
    if (exists == true) {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("Business Accounts Requests")
          .doc('${user}');
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.get('approvalStatus') == "waiting" &&
          documentSnapshot.get('profile_finish') == "unfinished") {
        num = 1;
      } else if (documentSnapshot.get('approvalStatus') == "approved" &&
          documentSnapshot.get('profile_finish') == "unfinished") {
        num = 2;
      } else if (documentSnapshot.get('approvalStatus') == "Rejected" &&
          documentSnapshot.get('profile_finish') == "unfinished") {
        num = 5;
      } else if (documentSnapshot.get('approvalStatus') == "approved" &&
          documentSnapshot.get('profile_finish') == "yes") {
        num = 3;
      }
    } else if (exists == false) {
      num = 4;
    }
    index = num;
    return index;
  }

  // Method to perform the overall account check
  Future<int> accountCheck() async {
    user = await getUser();
    if (user != null) {
      exists = await roleChecker(user!.uid.toString());
      index = await pageBuilder(user!.uid.toString(), exists!);
    } else {
      index = 4;
    }
    return index;
  }
}
