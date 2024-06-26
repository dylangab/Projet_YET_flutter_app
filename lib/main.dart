import 'package:cloud_firestore/cloud_firestore.dart';

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
import 'package:final_project/Services.dart/notiservice.dart';

import 'package:final_project/mainPage.dart';
import 'package:final_project/Pages/IndividualAccount/NotificationPage.dart';

import 'package:final_project/widgets/MostRated.dart';

import 'package:final_project/widgets/location.dart';
import 'package:final_project/Pages/IndividualAccount/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:final_project/Pages/BusinessAccount/BpRegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:final_project/LoginTab.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'Pages/BusinessAccount/BpPage.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    //  LocationPath().locationPath();
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerPeriodicTask("task-identifier", "simpleTask",
      frequency: const Duration(minutes: 30));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: GetLocation(),
    );
  }
}
