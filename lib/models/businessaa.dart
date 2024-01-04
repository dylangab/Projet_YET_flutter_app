// Importing necessary Dart and Flutter packages
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'storagemethod.dart';
import 'package:final_project/Services.dart/imagepicker.dart';
import 'package:latlong2/latlong.dart';

// Defining a class named Businessacc
class Businessacc {
  // Creating instances of Firebase authentication and Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method for registering a business account
  Future<String> regiserbusiness({
    required String businessname,
    required String businessaddress,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneno,
    required String bcatagory,
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

        // Storing business account details in Firestore
        await _firestore
            .collection('Business Accounts')
            .doc(cred.user!.uid)
            .set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': email,
          'Phone Number': phoneno,
          'Business Name': businessname,
          'Business Address': businessaddress,
          'timestamp': FieldValue.serverTimestamp()
        });
      }
    } catch (e) {
      // Catching and storing any exceptions
      res = e.toString();
    }
    // Returning the result string
    return res;
  }

  // Method for finishing the business account profile
  Future<String> finishAccount({
    required String businessaddress,
    required String profilefinish,
    required String description,
    required String coverPhoto,
    required String bcatagory,
    required String profilePic,
    required String? website,
    required LatLng coordinates,
  }) async {
    // Initializing the result string
    String res = "error occurred";
    try {
      // Checking if required fields are not empty
      if (businessaddress.isNotEmpty ||
          description.isNotEmpty ||
          bcatagory.isNotEmpty) {
        // Updating business account details in Firestore
        await _firestore
            .collection('Business Accounts Requests')
            .doc(_auth.currentUser!.uid)
            .update({
          'Business Address': businessaddress,
          'profile_Pic': profilePic,
          'description': description,
          'businesscatagory': bcatagory,
          'coverPhoto': coverPhoto,
          'profile_finish': profilefinish,
          'website': website,
          'coordinates': coordinates,
        });
      }
    } catch (e) {
      // Catching and storing any exceptions
      res = e.toString();
    }
    // Returning the result string
    return res;
  }

  // Method for requesting a business account
  Future<String> requestaccount({
    required String businessname,
    required String businessaddress,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneno,
    required String services,
    required String description,
    required String bcatagory,
    required List image,
    required String profilePic,
    required String coverPhoto,
    required String profilefinish,
    required String approvalStatus,
    required LatLng coordinates,
    required double? rating,
    required List? ratingList,
    required List? followerIdList,
    required String? website,
    required List rateUids,
    required reviews,
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

        // Storing business account request details in Firestore
        _firestore
            .collection("Business Accounts Requests")
            .doc(cred.user!.uid)
            .set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': email,
          'Phone Number': phoneno,
          'Business Name': businessname,
          'reviews': reviews,
          'Password': password,
          'bid': cred.user!.uid,
          'timestamp': FieldValue.serverTimestamp(),
          'service': services,
          'description': description,
          'businesscatagory': bcatagory,
          'photos': image,
          'approvalStatus': approvalStatus,
          'coverPhoto': coverPhoto,
          'profile_Pic': profilePic,
          'profile_finish': profilefinish,
          'rating': rating,
          'ratingList': ratingList,
          'followerIdList': followerIdList,
          'website': website,
          'coordinates': coordinates.toString(),
          'rateUids': rateUids,
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
