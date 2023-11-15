import 'package:flutter/material.dart';
import 'package:final_project/widgets/RecentlyAdded.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/BusinessAccount/buzpage1.dart';
import 'package:get/get.dart';

class reviews extends StatefulWidget {
  const reviews({super.key});

  @override
  _reviewsState createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  List<DocumentSnapshot> annoucmnet = [];
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Business Account Requests")
              .doc("${Get.arguments}")
              .collection("Comments")
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot.data);

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              annoucmnet = snapshot.data!.docs;
            }

            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 10,
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child:
                                  Text(annoucmnet[index]['comment'].toString()),
                            ),
                          ),
                        ],
                      ));
                });
          }),
    );
  }
}
