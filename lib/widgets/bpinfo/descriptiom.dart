import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';

class description extends StatefulWidget {
  @override
  _descriptionState createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  List description = [];

  

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
                description = snapshot.data!.docs;
                setState(() {});
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: description.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(description[index][''].toString()),
                    );
                  });
            }));
  }
}
