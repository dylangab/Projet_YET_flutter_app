import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class editindipro extends StatefulWidget {
  const editindipro({super.key});

  @override
  State<editindipro> createState() => _editindiproState();
}

class _editindiproState extends State<editindipro> {
  TextEditingController fullname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneno = TextEditingController();

  List bprofile = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Individual Account")
                .where('uid', isEqualTo: _auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);

              if (snapshot.data!.docs.isNotEmpty) {
                bprofile = snapshot.data!.docs;
                setState(() {});
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bprofile.length,
                  itemBuilder: (context, index) {
                    return ListView(
                      children: [
                        Form(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: email,
                                initialValue:
                                    bprofile[index]['email'].toString(),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: fullname,
                                initialValue:
                                    bprofile[index]['fullname'].toString(),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: lastname,
                                initialValue:
                                    bprofile[index]['lastname'].toString(),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: phoneno,
                                initialValue:
                                    bprofile[index]['phoneno'].toString(),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ],
                        )),
                        ElevatedButton(
                            onPressed: () async {
                              final FirebaseFirestore _firestore =
                                  FirebaseFirestore.instance;
                              await _firestore
                                  .collection('Individual Account')
                                  .doc(_auth.currentUser!.uid)
                                  .set({
                                'fullname': fullname,
                                'lastname': lastname,
                                'phoneno': phoneno,
                                'email': email,
                              });
                            },
                            child: const Text('save changes'))
                      ],
                    );
                  });
            }));
  }
}
