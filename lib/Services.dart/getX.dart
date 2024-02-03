// Importing necessary Dart and Flutter packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Controller for managing map-related data
class GetMapController extends GetxController {
  // Observable variables for map coordinates and place
  Rx<LatLng>? coordinates = LatLng(37.7749, -122.4194).obs;
  RxString place = "".obs;

  // Method to set coordinates and perform reverse geocoding
  void setCoordinates(LatLng point) async {
    coordinates!.value = point;
    try {
      // Perform reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
        localeIdentifier: 'en',
      );

      Placemark placemark = placemarks.first;

      place.value = "${placemark.locality}".toLowerCase();
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}

// Controller for interacting with Firestore data related to individual accounts
class FirestoreDataService extends GetxController {
  // Observable variable for the user name
  RxString userName = "".obs;

  // Method to fetch individual account data from Firestore
  void fetchIndiAccount(String uid) {
    final DocumentReference _myDocument =
        FirebaseFirestore.instance.collection("Individual Accounts").doc(uid);
    late Stream<DocumentSnapshot> myDocumentStream;
    late DocumentSnapshot myDocumentData;

    // Get initial data
    _myDocument.get().then((DocumentSnapshot snapshot) {
      myDocumentData = snapshot;
    });

    // Listen to changes in the document
    myDocumentStream = _myDocument.snapshots();

    myDocumentStream.listen((DocumentSnapshot snapshot) {
      // Update local variable with the latest data
      myDocumentData = snapshot;

      // Fetch a specific field from the updated document
      userName = snapshot['First Name'] + snapshot['Last Name'];
      print('Specific Field Updated: $userName');

      // Process the data or trigger any actions
      print('Received data: $snapshot');
    });
  }
}

// Controller for getting the current address based on the user's location
class GetAddress extends GetxController {
  // Observable variable for the current address
  RxString currentAddress = "".obs;

  // Method to get the current address based on the user's location
  Future<String> getCurrentAddress() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location permission denied by user");
    }

    try {
      // Get user's current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Perform reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'en',
      );

      Placemark placemark = placemarks.first;

      currentAddress.value = "${placemark.locality}".toLowerCase();
    } catch (e) {
      print("Error getting location: $e");
    }
    return currentAddress.value;
  }
}

// Controller for fetching individual account data from Firestore
class individualAccountFetch extends GetxController {
  // Observable variables for user name and interests
  RxString userName = "".obs;
  RxList userInterests = [].obs;
  RxString email = "".obs;

  // Method to interact with Firebase service to fetch individual account data
  Future<void> firebaseService(String uid) async {
    final DocumentReference reference =
        FirebaseFirestore.instance.collection("Indivdual Accounts").doc(uid);
    late Stream<DocumentSnapshot> stream;
    late DocumentSnapshot documentSnapshot;

    reference.get().then((value) => documentSnapshot = value);

    stream = reference.snapshots();
    stream.listen((event) {
      documentSnapshot = event;
      userName.value =
          "${documentSnapshot.get('First Name') + documentSnapshot.get('Last Name')}";
      userInterests.value = documentSnapshot.get('userInterest');
      email.value = "${documentSnapshot.get('email')}";
      print(userName.value);
    });
  }
}

class BuzAccountFetch extends GetxController {
  // Observable variables for user name and interests
  RxString userName = "".obs;

  RxString email = "".obs;

  // Method to interact with Firebase service to fetch individual account data
  Future<void> firebaseService(String bid) async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(bid);
    late Stream<DocumentSnapshot> stream;
    late DocumentSnapshot documentSnapshot;

    reference.get().then((value) => documentSnapshot = value);

    stream = reference.snapshots();
    stream.listen((event) {
      documentSnapshot = event;
      userName.value =
          "${documentSnapshot.get('First Name') + documentSnapshot.get('Last Name')}";

      email.value = "${documentSnapshot.get('email')}";
      print(userName.value);
    });
  }
}

class FetchLocation extends GetxController {
  RxString counter = "0".obs;
  RxDouble inicialpointlatitude = 0.00.obs;
  RxDouble inicialpointlongtude = 0.00.obs;
  RxDouble updatedpointlatitude = 0.00.obs;
  RxDouble updatedpointlongtude = 0.00.obs;

  Future<void> fetchLocationPath(String uid) async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(uid)
        .collection("LocationPath")
        .doc(uid);
    late Stream<DocumentSnapshot> stream;
    late DocumentSnapshot documentSnapshot;

    reference.get().then((value) => documentSnapshot = value);

    stream = reference.snapshots();
    stream.listen((event) {
      documentSnapshot = event;
      counter.value = documentSnapshot.get("counter");
      inicialpointlatitude.value =
          double.parse(documentSnapshot.get("inicialpointlatitude"));
      inicialpointlongtude.value =
          double.parse(documentSnapshot.get("inicialpointlongtude"));
      updatedpointlatitude.value =
          double.parse(documentSnapshot.get("updatedpointlatitude"));
      updatedpointlongtude.value =
          double.parse(documentSnapshot.get("updatedpointlongtude"));

      print(counter.value);
    });
  }
}

// class Geofencingervice extends GetxController {
//   RxList account = [].obs;

//   void fetchMarkerDataFromFirestore() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     QuerySnapshot querySnapshot = await firestore
//         .collection("Business Accounts Requests")
//         .where('profile_finish', isEqualTo: 'yes')
//         .get();

//     account.value = querySnapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//       return Geofencing(
//         bid: data['bid'] as String,
//         coordinate: LatLng(data['latitude'], data['longitude']),
//       );
//     }).toList();
//   }
// }
