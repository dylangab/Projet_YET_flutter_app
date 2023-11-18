import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/notiservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:final_project/Pages/IndividualAccount/EventPage.dart';
import 'package:final_project/Pages/IndividualAccount/Catagory.dart';
import 'package:final_project/Pages/IndividualAccount/NotificationPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  void initState() {
    super.initState();
    messageCheck();
  }

  Set<String> NotifideMessageId = Set<String>();
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu), label: 'Catagory'),
              BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
              BottomNavigationBarItem(
                  icon: Badge(
                    child: Icon(
                      Icons.notifications,
                    ),
                    label: Text("$counter"),
                  ),
                  label: 'Annocmnet'),
            ]),
        body: pages[currentindex]);
  }

  Future fetchAnnoucment() async {
    FirebaseFirestore.instance
        .collection('Annoucment')
        .where('status', isEqualTo: 'unseen')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        NotiService().showNoti(
            id: 0,
            title: doc['title'],
            body: doc['annoucment'],
            payload: 'adadad');
      }
    });
  }

  Future<void> messageCounter() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Annoucment')
        .where('status', isEqualTo: 'unseen')
        .get();

    counter = querySnapshot.size;
  }

  Future messageCheck() async {
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection('Annoucment');

    messagesCollection.snapshots().listen((QuerySnapshot snapshot) async {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          // A new document has been added to the collection
          String messageId;
          messageId = change.doc.id;
          // Trigger a local notification here
          if (!NotifideMessageId.contains(messageId)) {
            await fetchAnnoucment();
            await messageCounter();
            NotifideMessageId.add(messageId);
          }
        }
      }
    });
  }
}
