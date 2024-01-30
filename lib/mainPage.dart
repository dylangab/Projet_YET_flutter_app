import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:final_project/Pages/IndividualAccount/EventPage.dart';
import 'package:final_project/Pages/IndividualAccount/Catagory.dart';
import 'package:final_project/Pages/IndividualAccount/NotificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:final_project/Services.dart/getX.dart';
import 'package:final_project/Services.dart/notiservice.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  void initState() {
    fetchAnnoucment();
    super.initState();
    messageCheck();
    messageCounter();
    final individualAccountFetch controller = Get.put(individualAccountFetch());
    print(controller.userName.value);
    print(controller.userInterests.value);
  }

  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  List<String> NotifideMessageId = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List pages = [
    const MyHomePage(),
    const CatagoryPage(),
    const eventpage(),
    const indiannoucmnetpage(),
  ];
  int? counter = 0;
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: currentindex,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            onTap: onTap,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.menu), label: 'Catagory'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.event), label: 'Event'),
              BottomNavigationBarItem(
                  icon: Badge(
                    label: Text("$counter"),
                    child: const Icon(
                      Icons.notifications,
                    ),
                  ),
                  label: 'Annocmnet'),
            ]),
        body: pages[currentindex]);
  }

  Future fetchAnnoucment() async {
    FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(_auth.currentUser!.uid)
        .collection("messages")
        .where('status', isEqualTo: 'unseen')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          NotiService().showNoti(
              id: 0,
              title: doc['title'],
              body: doc['message'],
              payload: 'adadad');
        }
      } else {
        print("no message");
      }
    });
  }

  Future<int> messageCounter() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(_auth.currentUser!.uid)
        .collection("messages")
        .where('status', isEqualTo: 'unseen')
        .get();

    counter = querySnapshot.size;
    return counter!;
  }

  Future messageCheck() async {
    CollectionReference messagesCollection = FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(_auth.currentUser!.uid)
        .collection("messages");
    final SharedPreferences preferences = await _preferences;
    messagesCollection.snapshots().listen((QuerySnapshot snapshot) async {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          // A new document has been added to the collection
          String messageId;
          messageId = change.doc.id;
          // Trigger a local notification here
          var idList = await preferences.getStringList('idList') ?? [];
          if (idList.contains(messageId)) {
            await fetchAnnoucment();

            idList.add(messageId);
            await preferences.setStringList('idList', idList);
          }
        }
      }
    });
  }
}
