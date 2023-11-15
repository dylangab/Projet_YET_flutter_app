import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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
