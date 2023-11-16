import 'package:final_project/Pages/BusinessAccount/BpPage.dart';
import 'package:final_project/Pages/BusinessAccount/finishProfilePage.dart';
import 'package:final_project/Pages/BusinessAccount/waitingPage.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../mainPage.dart';
import '../../widgets/LoginTab.dart';

class AccountCheckPage extends StatefulWidget {
  const AccountCheckPage({super.key});

  @override
  State<AccountCheckPage> createState() => _AccountCheckPageState();
}

class _AccountCheckPageState extends State<AccountCheckPage> {
  @override
  void initState() {
    super.initState();
    accountcheck();
  }

  bool? exists;

  int? index;
  List<Widget> pagebuilder = [
    const LoginTab(),
    const WaitingPage(),
    const FinishProPage(),
    const BpPage(),
    const mainPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return pagebuilder[index!];
  }

  Future<void> pageBuilder(String adminStatus, String profileStatus) async {
    await checkUserAuthentication();
    if (adminStatus == "waiting" && profileStatus == "unfinished") {
      index = 1;
    } else if (adminStatus == "approved" && profileStatus == "unfinished") {
      index = 2;
    } else {
      index = 3;
    }
  }

  Future<void> checkUserAuthentication() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      await isDocumentExists(
          "Business Accounts Requests", auth.currentUser!.uid.toString());
      if (exists == true) {
        DocumentSnapshot docsnap = await FirebaseFirestore.instance
            .collection("")
            .doc(auth.currentUser!.uid.toString())
            .get();
        Map<String, dynamic> data = docsnap.data() as Map<String, dynamic>;
        await pageBuilder(data["waiting"], data["unfinished"]);
      } else if (exists == false) {
        index = 4;
      }
    } else {
      // User is not authenticated, navigate to the login page.
      index = 0;
    }
  }

  Future<void> isDocumentExists(String collection, String documentId) async {
    // Get a reference to the document
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(collection).doc(documentId);

    // Get the document
    DocumentSnapshot docSnapshot = await docRef.get();

    // Check if the document exists
    exists = docSnapshot.exists;
  }

  Future<int> accountcheck() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      await isDocumentExists(
          "Business Accounts Requests", auth.currentUser!.uid.toString());
      if (exists == true) {
        DocumentSnapshot docsnap = await FirebaseFirestore.instance
            .collection("")
            .doc(auth.currentUser!.uid.toString())
            .get();
        Map<String, dynamic> data = docsnap.data() as Map<String, dynamic>;
        await pageBuilder(data["waiting"], data["unfinished"]);
      } else if (exists == false) {
        index = 4;
      }
    } else {
      // User is not authenticated, navigate to the login page.
      index = 0;
    }
    return index!;
  }
}
