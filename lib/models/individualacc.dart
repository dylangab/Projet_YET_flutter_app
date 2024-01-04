// Importing necessary Dart and Flutter packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Defining a class named individualacc
class individualacc {
  // Creating instances of Firebase authentication and Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method for registering an individual account
  Future<String> regiseruser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneno,
    required List userInterest,
  }) async {
    // Initializing the result string
    String res = "error occurred";
    try {
      // Checking if required fields are not empty
      if (firstname.isNotEmpty ||
          lastname.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          phoneno.isNotEmpty) {
        // Creating a user with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Storing individual account details in Firestore
        await _firestore
            .collection('Indivdual Accounts')
            .doc(cred.user!.uid)
            .set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': email,
          'Phone Number': phoneno,
          'userInterest': userInterest,
          'uid': cred.user!.uid,
        });
      }
    } catch (e) {
      // Catching and storing any exceptions
      res = e.toString();
    }
    // Returning the result string
    return res;
  }
}
