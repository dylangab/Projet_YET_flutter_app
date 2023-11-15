// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String comment;
  final String username;
  final String businessid;
  final double ratiing;

  AddUser(this.comment, this.username, this.businessid, this.ratiing);

  CollectionReference users = FirebaseFirestore.instance.collection('Reviews');

  Future<void> addReview() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'comment': comment,
          'user name': username,
          'businessid': businessid,
          'Rating': ratiing
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
