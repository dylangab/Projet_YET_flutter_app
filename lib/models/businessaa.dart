import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'storagemethod.dart';
import 'package:final_project/models/imagepicker.dart';
import 'package:latlong2/latlong.dart';

class Businessacc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      res = e.toString();
    }
    return res;
  }

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
    String res = "error occured";
    try {
      if (businessaddress.isNotEmpty ||
          description.isNotEmpty ||
          bcatagory.isNotEmpty) {
        /* String photourl =
            await storagemethod().uplodimage('photos', file, false);*/

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
      res = e.toString();
    }
    return res;
  }

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

        _firestore
            .collection("Business Accounts Requests")
            .doc(cred.user!.uid)
            .set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': email,
          'Phone Number': phoneno,
          'Business Name': businessname,
          'Address': businessaddress,
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
      res = e.toString();
    }
    return res;
  }
}
