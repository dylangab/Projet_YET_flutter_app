import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Annoucmentpage extends StatefulWidget {
  const Annoucmentpage({super.key});

  @override
  _AnnoucmentpageState createState() => _AnnoucmentpageState();
}

class _AnnoucmentpageState extends State<Annoucmentpage> {
  TextEditingController annoucmnet = TextEditingController();
  TextEditingController businessname = TextEditingController();
  List tokenList = [];
  List userIdList = [];
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Annoucment'),
                    ),
                    TextFormField(
                      controller: annoucmnet,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            for (var followerId in userIdList) {
                              await saveMessage(followerId)
                                  .then((value) => null);
                            }
                          },
                          child: const Text('Send Annoucment'),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getTokenList() async {
    await FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc('FirebaseAuth.instance.currentUser!.uid')
        .collection("followers")
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                  tokenList.add(doc["deviceToken"]);
                }));
  }

  void getUserId() async {
    await FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("followers")
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                  tokenList.add(doc["uid"]);
                }));
  }

  Future<void> saveMessage(followerId) async {
    await FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc(followerId)
        .collection('message')
        .add({
      'senderName': "",
      'timestamp': FieldValue.serverTimestamp(),
      'message': annoucmnet,
    });
  }
}
