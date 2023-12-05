import 'package:final_project/Pages/BusinessAccount/buzpage1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/RecentlyAdded.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../models/notiservice.dart';

class indiannoucmnetpage extends StatefulWidget {
  const indiannoucmnetpage({super.key});

  @override
  _indiannoucmnetpageState createState() => _indiannoucmnetpageState();
}

class _indiannoucmnetpageState extends State<indiannoucmnetpage> {
  List<DocumentSnapshot> annoucmnet = [];
  bool? notification;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String text = loremIpsum(words: 20, initWithLorem: true);
  Widget build(BuildContext context) {
    Future<int> counter = messageCounter();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(232, 255, 255, 255),
        ),
        drawer: const Drawer(),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Annoucments',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Indivdual Accounts")
                        .doc(_auth.currentUser!.uid)
                        .collection("messages")
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot.data);

                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        annoucmnet = snapshot.data!.docs;
                        notification = true;
                      } else {
                        notification = false;
                      }
                      return notification!
                          ? ListView.builder(
                              itemCount: annoucmnet.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 50, 15, 0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: 400,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => buzpage(),
                                              arguments: annoucmnet[index]
                                                  ["bid"]);
                                        },
                                        child: Card(
                                          shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          color: const Color.fromARGB(
                                              255, 238, 240, 235),
                                          elevation: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: SizedBox(
                                                      width: 255,
                                                      child: Text(
                                                        annoucmnet[index]
                                                            ["message"],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .more_horiz_sharp))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 8, 0, 10),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(annoucmnet[
                                                                      index]
                                                                  ["profilePic"]
                                                              .toString()),
                                                      radius: 18,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: Text(
                                                      "${annoucmnet[index]["timestamp"].toString()}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              },
                            )
                          : Center(
                              child: Text("No messages yet..."),
                            );
                    }),
              ),
            )
          ],
        )

        /* StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("Annoucment").snapshots(),
          builder: (context, snapshot) {
            print(snapshot.data);

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              annoucmnet = snapshot.data!.docs;
            }

            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                              child: Text(
                                'Annoucment :',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                              child: Container(
                                child: Text(
                                    annoucmnet[index]['annoucment'].toString()),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Text(
                                    'Business Name :',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      annoucmnet[index]['businessname']
                                          .toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  );
                });
          }),*/
        );
  }

  Future<int> messageCounter() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('individual aAcount')
        .doc(_auth.currentUser!.uid)
        .collection('annoucments')
        .where('status', isEqualTo: 'unseen')
        .get();

    return querySnapshot.size;
  }
}
