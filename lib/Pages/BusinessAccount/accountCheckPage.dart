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
    checkUserAuthentication();
  }

  bool? exists;

  int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> pageBuilder(String adminStatus, String profileStatus) async {
    if (adminStatus == "waiting" && profileStatus == "unfinished") {
      Get.to(() => const WaitingPage());
    } else if (adminStatus == "approved" && profileStatus == "unfinished") {
      Get.to(() => const FinishProPage());
    } else {
      Get.to(() => const BpPage());
    }
  }

  void checkUserAuthentication() async {
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
        Get.to(() => const MyHomePage());
      }
    } else {
      // User is not authenticated, navigate to the login page.
      Get.to(() => const LoginTab());
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
}
