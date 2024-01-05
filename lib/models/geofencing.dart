import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../Services.dart/getX.dart';
import '../Services.dart/notiservice.dart';

// s
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
      _positionStreamSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        for (var element in list1) {
          sendNotificaion(
              LatLng(position!.latitude, position.longitude),
              LatLng(
                  element.coordinate!.latitude, element.coordinate!.longitude));
        }
      });
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
