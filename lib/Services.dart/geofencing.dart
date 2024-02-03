import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../Services.dart/getX.dart';
import '../../Services.dart/notiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
// s

// class CurrentPosition {
//   void currentPosition(Position? position) async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
// }

// class GeofencData {
//   Position? updatedPosition;
//   Position? currentPosition;
//   int? distance;
// }

class Distance {
  Future<int> calculateDistance(double inicalLatitude, double inicalLongtude,
      double updatedLatitude, double UpdatedLongtude) async {
    int distance;
    distance = Geolocator.distanceBetween(
            inicalLatitude, inicalLongtude, updatedLatitude, UpdatedLongtude)
        .ceil();
    return distance;
  }
}

class InciateGeofence {
  void inciate(var uid) async {
    FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(uid)
        .collection("LocationPath")
        .doc(uid)
        .set(
            {'inicalLatitude': "0.00", 'inicalLongtude': "0.00", 'counter': 0});
  }
}

class LocationPath {
  final FetchLocation controller = Get.put((FetchLocation()));

  void locationPath(var uid) async {
    await controller.fetchLocationPath(uid);
    int? counter = controller.counter.value as int?;
    double inicalLatitude = controller.inicialpointlatitude.value;
    double inicalLongtude = controller.inicialpointlongtude.value;

    if (counter == 0) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      FirebaseFirestore.instance
          .collection("Indivdual Accounts")
          .doc(uid)
          .collection("LocationPath")
          .doc(uid)
          .update({
        'inicalLatitude': position.latitude,
        'inicalLongtude': position.longitude
      });
    } else if (counter! < 3) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await controller.fetchLocationPath(uid);
      int i = await Distance().calculateDistance(
          position.latitude,
          position.longitude,
          controller.inicialpointlatitude.value,
          controller.inicialpointlongtude.value);
      if (i > 100) {
        FirebaseFirestore.instance
            .collection("Indivdual Accounts")
            .doc(uid)
            .collection("LocationPath")
            .doc(uid)
            .update({
          'inicalLatitude': position.latitude,
          'inicalLongtude': position.longitude
        });
        counter++;
        FirebaseFirestore.instance
            .collection("Indivdual Accounts")
            .doc(uid)
            .collection("LocationPath")
            .doc(uid)
            .update({
          'counter': counter,
        });
      } else {
        counter = 0;
        FirebaseFirestore.instance
            .collection("Indivdual Accounts")
            .doc(uid)
            .collection("LocationPath")
            .doc(uid)
            .update({
          'counter': counter,
        });
      }
    } else if (counter == 3) {
      await controller.fetchLocationPath(uid);
      // query Snapshot

      NotiService().showNoti(
          id: 0, title: "Check Us Out", body: 'coffee', payload: 'adadad');

      // for (var element in list) {
      //   int i = await Distance().calculateDistance(
      //       double.parse(element["inicalLatitude"]),
      //       double.parse(element["inicalLongtude"]),
      //       controller.inicialpointlatitude.value,
      //       controller.inicialpointlongtude.value);
      //   if (i < 100) {
      //     NotiService().showNoti(
      //         id: 0,
      //         title: "Check Us Out",
      //         body: element['Business Name'],
      //         payload: 'adadad');
      //   }
      // }
    }
  }
}

// class LocationPath1 {
//   int counter = 0;
//   double latitude = 0.00;
//   double longitude = 0.00;

//   void locationPath(
//     Position? currentPosition,
//   ) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setInt('counter', LocationPath().counter);

//     currentPosition = GeofencData().currentPosition;
//     Position updatedPosition = GeofencData().updatedPosition!;
//     int counter = await preferences.getInt('counter') ?? 0;

//     int distance;
//     if (currentPosition == null) {
//       CurrentPosition().currentPosition(GeofencData().currentPosition);
//     } else {
//       CurrentPosition().currentPosition(GeofencData().updatedPosition);
//       distance = Distance().calculateDistance(currentPosition, updatedPosition);
//       if (distance < 100) {
//         currentPosition = updatedPosition;
//         await preferences.setInt('counter', 0);
//       } else if (counter != 8 && distance < 100) {
//         counter++;
//         await preferences.setInt('counter', counter);
//       } else if (counter == 8 && distance < 100) {
//         List<DocumentSnapshot> list =
//             await FetchData().fetchMarkerDataFromFirestore();
//         for (var element in list) {
//           SendNotification().sendNotificaion(
//               currentPosition,
//               LatLng(double.parse(element['latitude'] as String),
//                   double.parse(element['longitude'] as String)));
//         }
//       }
//     }
//   }
// }

// class Geofencing {
//   String? bid;
//   LatLng? coordinate;
//   Geofencing({
//     required this.bid,
//     required this.coordinate,
//   });
// }

class FetchData {
  // Future<List<DocumentSnapshot>> fetchMarkerDataFromFirestore() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   QuerySnapshot querySnapshot = await firestore
  //       .collection("Business Accounts Requests")
  //       .where('profile_finish', isEqualTo: 'yes')
  //       .get();
  //   List<DocumentSnapshot> fenceList = querySnapshot.docs;

  //   return fenceList;
  // }
  // Future<List<Map<String, dynamic>>> fetchData() async {
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('').get();
  //   List<DocumentSnapshot> dataLit = [];
  //   for (QueryDocumentSnapshot document in querySnapshot.docs) {
  //     var data = document.data();

  //     dataLit.add(data);
  //   }
  // }
}

// class SendNotification {
//   void sendNotificaion(Position userLocation, LatLng businessLocation) {
//     int distance = Geolocator.distanceBetween(
//             userLocation.latitude,
//             userLocation.longitude,
//             businessLocation.latitude,
//             businessLocation.longitude)
//         .ceil();

//     if (distance <= 100) {
//       NotiService().showNoti(
//           id: 0,
//           title: "Your friendly reminder",
//           body: "we are rody cafe come check us out ",
//           payload: 'adadad');
//     }
//   }
// }

 






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