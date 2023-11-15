import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MostRated extends StatefulWidget {
  const MostRated({super.key});

  @override
  _MostRatedState createState() => _MostRatedState();
}

class _MostRatedState extends State<MostRated> {
  List comments = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Reviews")
                .where('bid', isEqualTo: _auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);

              if (snapshot.data!.docs.isNotEmpty) {
                comments = snapshot.data!.docs;
                setState(() {});
              }

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Row(
                      children: [
                        Text(''),
                      ],
                    ));
                  });
            }));
  }
}
