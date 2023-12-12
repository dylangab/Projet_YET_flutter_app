import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Pages/BusinessAccount/buzpage1.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<MapMarker> markerList = [];

  @override
  void initState() {
    super.initState();
    fetchMarkerDataFromFirestore();
  }

  void fetchMarkerDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection("Business Accounts Requests")
        .where('profile_finish', isEqualTo: 'yes')
        .get();

    List<MapMarker> markers = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return MapMarker(
        profileId: data['bid'] as String,
        name: data['Business Name'] as String,
        coordinates: LatLng(data['latitude'], data['longitude']),
      );
    }).toList();

    setState(() {
      markerList = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center:
            LatLng(37.7749, -122.4194), // Center the map at a specific location
        zoom: 5.0, // Set the initial zoom level
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: markerList.map((MapMarker mapMarker) {
            return Marker(
              width: 80.0,
              height: 80.0,
              point: mapMarker.coordinates,
              builder: (ctx) => Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 229, 143, 101),
                    ),
                  ),
                  SizedBox(height: 4), // Adjust spacing between icon and label
                  GestureDetector(
                    onTap: () async {
                      await Get.to(() => buzpage(),
                          arguments: mapMarker.profileId);
                    },
                    child: Text(
                      mapMarker.name,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MapMarker {
  final String name;
  final LatLng coordinates;
  final String profileId;

  MapMarker(
      {required this.name, required this.coordinates, required this.profileId});
}
