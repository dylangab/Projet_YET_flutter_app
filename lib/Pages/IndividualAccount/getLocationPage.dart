import 'package:final_project/mainPage.dart';
import 'package:final_project/Services.dart/getX.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final GetAddress controller = Get.put(GetAddress());
  final individualAccountFetch controller1 = Get.put(individualAccountFetch());
  String? add;
  String? name;
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: controller.getCurrentAddress.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String address;
          address = snapshot.toString();

          //  Get.to(mainPage(), arguments: address);
          return Container(
            child: SizedBox(
                height: 100,
                child: Center(
                    child: Text(controller.currentAddress.value + address))),
          ); //mainPage();
        } else {
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        }
      },
    ));
  }
}
