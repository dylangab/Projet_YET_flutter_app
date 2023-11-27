import 'package:final_project/models/getX.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final GetAddress controller = Get.put(GetAddress());
  String? add;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Step 2/2",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "We will need your location",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                // Request location permission
                controller.getCurrentAddress.call();
                add = controller.currentAddress.value;
                print(add);
              },
              icon: Icon(Icons.location_on),
              label: Text("Get location")),
          Text(controller.currentAddress.value)
        ],
      ),
    );
  }
}
