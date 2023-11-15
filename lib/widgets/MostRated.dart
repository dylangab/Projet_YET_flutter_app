import 'package:final_project/Pages/BusinessAccount/BusinessProfile.dart';
import 'package:final_project/Pages/BusinessAccount/buzpage1.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/Pages/BusinessAccount/businesspage.dart';
import 'package:get/get.dart';

class MostRated extends StatefulWidget {
  @override
  _MostRatedState createState() => _MostRatedState();
}

class _MostRatedState extends State<MostRated> {
  List<DocumentSnapshot> mostrated = [];

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
                  .where('profile_finish', isEqualTo: 'yes')
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  mostrated = snapshot.data!.docs;
                }

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          var data = await Get.to(() => buzpage(),
                              arguments: mostrated[index]["bid"]);
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
                                            mostrated[index]["coverPhoto"]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  width: 150,
                                  height: 300,
                                ),
                                Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Text(
                                      '${mostrated[index]["Business Name"]}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
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
