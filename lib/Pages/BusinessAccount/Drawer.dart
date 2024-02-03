import 'package:final_project/Pages/BusinessAccount/editprofile.dart';
import 'package:final_project/Pages/IndividualAccount/MessagePage.dart';

import 'package:final_project/LoginTab.dart';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktoklikescroller/controller.dart';

import '../../Services.dart/getX.dart';

class BuzDraer extends StatefulWidget {
  const BuzDraer({super.key});

  @override
  _BuzDraerState createState() => _BuzDraerState();
}

class _BuzDraerState extends State<BuzDraer> {
  @override
  void initState() {
    super.initState();

    final BuzAccountFetch controller = Get.put(BuzAccountFetch());
    controller.firebaseService.call;
    print(controller.userName.value);
  }

  final BuzAccountFetch controller = Get.put(BuzAccountFetch());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      surfaceTintColor: Colors.black45,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 238, 240, 235)),
              currentAccountPicture: CircleAvatar(),
              accountName: Obx(() => Text("${controller.userName.value}")),
              accountEmail: Obx(() => Text("${controller.email.value}"))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.mail_32_filled),
                title: const Text('My Messages'),
                onTap: () {
                  Get.to(() => const MessagePage(),
                      transition: Transition.fade);
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.edit_32_filled),
                title: const Text('Edit Profile'),
                onTap: () {
                  Get.to(() => const ProfileEditPage(),
                      transition: Transition.fade);
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.settings_32_filled),
                title: const Text('Settings'),
                onTap: () {},
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.phone_32_regular),
                title: const Text('Contact Us'),
                onTap: () {},
              )),
          const Divider(
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
            color: Colors.black38,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: ListTile(
                leading: const Icon(FluentIcons.arrow_exit_20_regular),
                title: const Text('Log out'),
                onTap: () {
                  FirebaseAuth.instance.signOut();

                  Get.to(() => const LoginTab(), transition: Transition.fade);
                },
              ))
        ],
      ),
    );
  }
}
