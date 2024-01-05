import 'package:final_project/Pages/BusinessAccount/buzpage1.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Services.dart/getX.dart';

class MostRated extends StatefulWidget {
  @override
  _MostRatedState createState() => _MostRatedState();
}

class _MostRatedState extends State<MostRated> {
  List<DocumentSnapshot> mostrated = [];
  bool MostRatedExist = false;
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
                  mostrated = snapshot.data!.docs;
                  MostRatedExist = true;

                  return MostRatedExist
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await Get.to(() => buzpage(),
                                    arguments: mostrated[index]["bid"],
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
                                                  mostrated[index]
                                                      ["coverPhoto"]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: 150,
                                        height: 300,
                                        child: const Text(''),
                                      ),
                                      Positioned(
                                          bottom: 20,
                                          left: 20,
                                          child: Text(
                                            '${mostrated[index]["Business Name"]}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ])),
                              ),
                            );
                          })
                      : const SizedBox(
                          height: 300,
                          child: Center(
                            child: Text(
                                "Sorry no registerd business in your locality"),
                          ),
                        );
                } else {
                  return const SizedBox(
                    child: Center(
                      child:
                          Text('Sorry no registerd business in your locality'),
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
