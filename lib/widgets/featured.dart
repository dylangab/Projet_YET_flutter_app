import 'package:final_project/Pages/BusinessAccount/BusinessProfile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/Pages/BusinessAccount/businesspage.dart';
import 'package:get/get.dart';

import '../Pages/BusinessAccount/buzpage1.dart';
import '../models/getX.dart';

class featured extends StatefulWidget {
  @override
  _featuredState createState() => _featuredState();
}

class _featuredState extends State<featured> {
  List<DocumentSnapshot> fearured = [];
  List dd = ["resturants", "educational", "barbor"];

  @override
  Widget build(BuildContext context) {
    final individualAccountFetch controller = Get.put(individualAccountFetch());
    // ignore: invalid_use_of_protected_member
    List bb = controller.userInterests.value;
    return Column(
      children: [
        // most rated
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Business Accounts Requests")
                  .where('businesscatagory', whereIn: dd)
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(1),
                                    width: 150,
                                    height: 300,
                                  ),
                                )),
                          );
                        }),
                  );
                }

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  fearured = snapshot.data!.docs;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            var data = await Get.to(() => buzpage(),
                                arguments: fearured[index]["bid"],
                                transition: Transition.zoom);
                          },
                          child: SizedBox(
                            child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Stack(children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              fearured[index]["image"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: 150,
                                    height: 300,
                                    child: Text(''),
                                  ),
                                  Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: Text(
                                          '${fearured[index]["Business Name"]}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)))
                                ])),
                          ),
                        );
                      });
                } else {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text("Server Error!!"),
                    ),
                  );
                }
              }),
        ),

        //
      ],
    );
  }
}
