import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Pages/BusinessAccount/buzpage1.dart';
import '../Services.dart/getX.dart';

class RecentlyAdded extends StatefulWidget {
  @override
  _RecentlyAddedState createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {
  List<DocumentSnapshot> RecentlyAdded = [];
  final GetAddress controller = Get.put(GetAddress());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // most rated
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Business Accounts Requests")
                  .where('Business Address',
                      isEqualTo: controller.currentAddress.value)
                  .where('profile_finish', isEqualTo: 'yes')
                  .orderBy('timestamp', descending: true)
                  .limit(2)
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  RecentlyAdded = snapshot.data!.docs;
                }

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: RecentlyAdded.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await Get.to(() => buzpage(),
                              arguments: RecentlyAdded[index]["bid"]);
                        },
                        child: SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Stack(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(1),
                                  child: const Text(''),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            RecentlyAdded[index]["coverPhoto"]),
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
                                        style: const TextStyle(
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
