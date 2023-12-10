import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/BusinessAccount/BusinessProfile.dart';

import 'package:final_project/Pages/BusinessAccount/accountCheckPage.dart';
import 'package:final_project/Pages/BusinessAccount/buzpage1.dart';
import 'package:final_project/Pages/BusinessAccount/chooseLocation.dart';
import 'package:final_project/Pages/BusinessAccount/editprofile.dart';
import 'package:final_project/Pages/BusinessAccount/finishProfilePage.dart';
import 'package:final_project/Pages/BusinessAccount/waitingPage.dart';
import 'package:final_project/Pages/IndividualAccount/Catagory.dart';
import 'package:final_project/Pages/IndividualAccount/EventPage.dart';
import 'package:final_project/Pages/IndividualAccount/IndiAccount.dart';
import 'package:final_project/Pages/IndividualAccount/InterestPage.dart';
import 'package:final_project/Pages/IndividualAccount/MessagePage.dart';
import 'package:final_project/Pages/IndividualAccount/NotificationPage.dart';
import 'package:final_project/Pages/IndividualAccount/Oops.dart';
import 'package:final_project/Pages/IndividualAccount/SearchPage.dart';
import 'package:final_project/Pages/IndividualAccount/explorepage.dart';
import 'package:final_project/Pages/IndividualAccount/getLocationPage.dart';
import 'package:final_project/localnoti.dart';
import 'package:final_project/mainPage.dart';
import 'package:final_project/Pages/IndividualAccount/NotificationPage.dart';
import 'package:final_project/widgets/MostRated.dart';
import 'package:final_project/widgets/buzLoginPage.dart';
import 'package:final_project/widgets/location.dart';
import 'package:final_project/widgets/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:final_project/Pages/BusinessAccount/BpRegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:final_project/Pages/BusinessAccount/businesspage.dart';
import 'package:final_project/widgets/LoginTab.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'Pages/BusinessAccount/BpPage.dart';
import 'models/getX.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PropertyController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const LoginTab(),
    );
  }
}
