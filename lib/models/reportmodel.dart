import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reportuser {
  final String issue;
  final String reporteduser;
  final String reporter;

  Reportuser(
    this.issue,
    this.reporteduser,
    this.reporter,
  );

  CollectionReference users =
      FirebaseFirestore.instance.collection('Reported User');

  Future<void> addReview() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'Issue': issue,
          'Reported user': reporteduser,
          'reporter': reporter,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class Reportbusiness {
  final String issue;
  final String reportedbusiness;
  final String reporteruser;

  Reportbusiness(
    this.issue,
    this.reportedbusiness,
    this.reporteruser,
  );

  CollectionReference users =
      FirebaseFirestore.instance.collection('Reported Business');

  Future<void> addReview() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'Issue': issue,
          'Reported user': reportedbusiness,
          'reporter': reporteruser,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
