import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../Services.dart/getX.dart';
import '../Services.dart/notiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
// s

class CurrentPosition {
  void currentPosition(Position? position) async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

class GeofencData {
  Position? updatedPosition;
  Position? currentPosition;
  int? distance;
}

class Distance {
  int calculateDistance(Position currentPosition, Position updatedPosition) {
    int distance;
    distance = Geolocator.distanceBetween(
            updatedPosition.latitude,
            updatedPosition.longitude,
            currentPosition.latitude,
            currentPosition.longitude)
        .ceil();
    return distance;
  }
}

class LocationPath {
  void locationPath(
    Position? currentPosition,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    currentPosition = GeofencData().currentPosition;
    Position updatedPosition = GeofencData().updatedPosition!;
    int counter = await preferences.getInt('counter') ?? 0;
    int distance;
    if (currentPosition == null) {
      CurrentPosition().currentPosition(GeofencData().currentPosition);
    } else {
      CurrentPosition().currentPosition(GeofencData().updatedPosition);
      distance = Distance().calculateDistance(currentPosition, updatedPosition);
      if (distance < 100) {
        currentPosition = updatedPosition;
        await preferences.setInt('counter', 0);
      } else if (counter != 8 && distance < 100) {
        counter++;
        await preferences.setInt('counter', counter);
      } else if (counter == 8 && distance < 100) {
        List<DocumentSnapshot> list =
            await FetchData().fetchMarkerDataFromFirestore();
        for (var element in list) {
          SendNotification().sendNotificaion(
              currentPosition,
              LatLng(double.parse(element['latitude'] as String),
                  double.parse(element['longitude'] as String)));
        }
      }
    }
  }
}

class Geofencing {
  String? bid;
  LatLng? coordinate;
  Geofencing({
    required this.bid,
    required this.coordinate,
  });
}

class FetchData {
  Future<List<DocumentSnapshot>> fetchMarkerDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection("Business Accounts Requests")
        .where('profile_finish', isEqualTo: 'yes')
        .get();
    List<DocumentSnapshot> fenceList = querySnapshot.docs;

    return fenceList;
  }
}

class SendNotification {
  void sendNotificaion(Position userLocation, LatLng businessLocation) {
    int distance = Geolocator.distanceBetween(
            userLocation.latitude,
            userLocation.longitude,
            businessLocation.latitude,
            businessLocation.longitude)
        .ceil();

    if (distance <= 100) {
      NotiService().showNoti(
          id: 0,
          title: "Your friendly reminder",
          body: "we are rody cafe come check us out ",
          payload: 'adadad');
    }
  }
}

 






/*
class Geofencing {
  String? bid;
  LatLng? coordinate;

  Geofencing({
    required this.bid,
    required this.coordinate,
  });
  final Geofencingervice controller = Get.put(Geofencingervice());
  Future<void> listenToUserLocation() async {
    List<Geofencing> list1 = await fetchMarkerDataFromFirestore();
    try {
      late StreamSubscription<Position> _positionStreamSubscription;
      const LocationSettings locationSettings = LocationSettings(
        timeLimit: Duration(seconds: 10),
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
      );
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print(e);
    }
  }

  int calculateDistance(LatLng userLocation, LatLng businessLocation) {
    double distance = Geolocator.distanceBetween(
        businessLocation.latitude,
        businessLocation.longitude,
        userLocation.latitude,
        userLocation.longitude);

    return distance.ceil();
  }

  void sendNotificaion(LatLng userLocation, LatLng businessLocation) {
    int distance = calculateDistance(userLocation, businessLocation);

    if (distance <= 100) {
      NotiService().showNoti(
          id: 0,
          title: "Your friendly reminder",
          body: "we are rody cafe come check us out ",
          payload: 'adadad');
    }
  }

  Future<List<Geofencing>> fetchMarkerDataFromFirestore() async {
    List<Geofencing> fenceList = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection("Business Accounts Requests")
        .where('profile_finish', isEqualTo: 'yes')
        .get();

    List<Geofencing> fence = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Geofencing(
        bid: data['bid'] as String,
        coordinate: LatLng(data['latitude'], data['longitude']),
      );
    }).toList();
    fenceList = fence;
    return fenceList;
  }
}
*/