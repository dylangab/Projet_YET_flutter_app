import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MyLocationPage extends StatefulWidget {
  @override
  _MyLocationPageState createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  String currentAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Address')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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
                    currentAddress =
                        " ${placemark.locality}, ${placemark.street}, ${placemark.administrativeArea}, ${placemark.subAdministrativeArea},${placemark.subLocality}";
                  });
                } catch (e) {
                  print("Error getting location: $e");
                }
              },
              child: Text('Get Current Address'),
            ),
            SizedBox(height: 16),
            Text(currentAddress),
          ],
        ),
      ),
    );
  }
}
