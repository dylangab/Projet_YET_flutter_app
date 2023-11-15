import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/models/models.dart';

class services extends StatefulWidget {
  @override
  _servicesState createState() => _servicesState();
}

class _servicesState extends State<services> {
  List services = [];

  

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
                services = snapshot.data!.docs;
                setState(() {});
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(services[index][''].toString()),
                    );
                  });
            }));
  }
}