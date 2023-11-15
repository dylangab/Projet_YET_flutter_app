import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class individualacc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> regiseruser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneno,
    required devicetoken,
  }) async {
    String res = "error occured";
    try {
      if (firstname.isNotEmpty ||
          lastname.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          phoneno.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firestore
            .collection('Indivdual Accounts')
            .doc(cred.user!.uid)
            .set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': email,
          'Phone Number': phoneno,
          'devicetoken': devicetoken,
          'uid': cred.user!.uid,
        });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
