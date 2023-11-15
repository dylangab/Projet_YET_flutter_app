import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class eventrequest {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> requestpost({
    required String eventname,
    required String eventlocation,
    required String eventdate,
    required String eventdescription,
  }) async {
    String res = "error occured";
    try {
      if (eventdate.isNotEmpty ||
          eventdescription.isNotEmpty ||
          eventlocation.isNotEmpty ||
          eventname.isNotEmpty) {
        await _firestore.collection('Events').doc().set({
          'Event name': eventname,
          'Event description': eventdescription,
          'Event Location': eventlocation,
          'Event date': eventdate,
        });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
