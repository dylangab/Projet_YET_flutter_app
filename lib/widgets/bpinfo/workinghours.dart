import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';

class workinghours extends StatefulWidget {
  @override
  _workinghoursState createState() => _workinghoursState();
}

class _workinghoursState extends State<workinghours> {
  List workinghours = [];

  @override
  Widget build(BuildContext context) {
    String businessid;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("bussines_accounts")
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);

              if (snapshot.data!.docs.isNotEmpty) {
                workinghours = snapshot.data!.docs;
                setState(() {});
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: workinghours.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: Text(workinghours[index][''].toString()),
                        ),
                        Container(
                          child: Text(workinghours[index][''].toString()),
                        ),
                      ],
                    );
                  });
            }));
  }
}
