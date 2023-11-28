import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PropertyController extends GetxController {
  var primaryColor = const Color.fromARGB(0, 229, 143, 101).obs;
  var secondaryColor = const Color.fromARGB(0, 66, 106, 90).obs;
  var surfaceColor1 = const Color.fromARGB(0, 238, 240, 235).obs;
  var surfaceColor2 = const Color.fromARGB(0, 244, 249, 233).obs;
  var header1 = 0.obs;
  var header2 = 0.obs;
  var header3 = 0.obs;
  var text = 0.obs;
}

class GetMapController extends GetxController {
  Rx<LatLng>? coordinates = LatLng(37.7749, -122.4194).obs;

  void setCoordinates(LatLng point) {
    coordinates!.value = point;
  }
}

class FirestoreDataService extends GetxController {
  RxString userName = "".obs;

  void fetchIndiAccount(String uid) {
    final DocumentReference _myDocument =
        FirebaseFirestore.instance.collection("Individual Accounts").doc(uid);
    late Stream<DocumentSnapshot> myDocumentStream;
    late DocumentSnapshot myDocumentData;
    // Get initial data
    _myDocument.get().then((DocumentSnapshot snapshot) {
      myDocumentData = snapshot;

      // Fetch a specific field from the document
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

class GetAddress extends GetxController {
  RxString currentAddress = "".obs;

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

      currentAddress.value = "${placemark.locality}";
    } catch (e) {
      print("Error getting location: $e");
    }
    return currentAddress.value;
  }
}

class individualAccountFetch extends GetxController {
  RxString userName = "".obs;

  Future<void> firebaseService() async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc("vGM1BF3bW7bcIYgrGLvY6vzClRu1");
    late Stream<DocumentSnapshot> stream;
    late DocumentSnapshot documentSnapshot;

    reference.get().then((value) => documentSnapshot = value);

    stream = reference.snapshots();
    stream.listen((event) {
      documentSnapshot = event;
      userName.value =
          "${documentSnapshot.get('First Name') + documentSnapshot.get('Last Name')}";
    });
  }
}
