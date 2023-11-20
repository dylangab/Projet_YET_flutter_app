import 'package:final_project/Pages/BusinessAccount/BusinessProfile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/Pages/BusinessAccount/businesspage.dart';
import 'package:get/get.dart';

import '../Pages/BusinessAccount/buzpage1.dart';

class RecentlyAdded extends StatefulWidget {
  @override
  _RecentlyAddedState createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {
  List<DocumentSnapshot> RecentlyAdded = [];

  List businessdetil = [];

  @override
  Widget build(BuildContext context) {
    String businessid;
    return Column(
      children: [
        // most rated
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Business Accounts Requests")
                  .orderBy('timestamp', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  RecentlyAdded = snapshot.data!.docs;
                }

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          var data = await Get.to(() => buzpage(),
                              arguments: RecentlyAdded[index]["bid"]);
                        },
                        child: SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Stack(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(1),
                                  child: Text(''),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            RecentlyAdded[index]["image"]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  width: 150,
                                  height: 400,
                                ),
                                Positioned(
                                    bottom: 20,
                                    left: 25,
                                    child: Text(
                                        '${RecentlyAdded[index]["Business Name"]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)))
                              ])),
                        ),
                      );
                    });
              }),
        ),

        //
      ],
    );
  }
}
