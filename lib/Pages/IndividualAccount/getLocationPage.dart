import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  String currentAddress = '';
  Widget build(BuildContext context) {
    return Column(
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
              LocationPermission permission =
                  await Geolocator.requestPermission();
              if (permission == LocationPermission.denied ||
                  permission == LocationPermission.deniedForever) {
                print("Location permission denied by user");
                return;
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
                setState(() {
                  currentAddress = " ${placemark.locality}";
                });
              } catch (e) {
                print("Error getting location: $e");
              }
              print(currentAddress);
            },
            icon: Icon(Icons.location_on),
            label: Text("Get location"))
      ],
    );
  }
}
