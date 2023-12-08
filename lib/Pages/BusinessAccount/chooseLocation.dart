import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../models/getX.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

LatLng? selectedCoordinates = const LatLng(37.7749, -122.4194);
late TapPosition tapPosition;

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  MapController mapController = MapController();
  final GetMapController controller = Get.put(GetMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(selectedCoordinates.toString());
        Get.back();
      }),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: const LatLng(0, 0), // Set your initial map center
          zoom: 10.0,
          onTap: (tap, position) {
            setState(() {
              controller.setCoordinates(position);
            });
          },
          // Set your initial zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          // Add your tile layer options

          MarkerLayer(
            markers: [
              if (selectedCoordinates != null)
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: controller.coordinates!.value,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
