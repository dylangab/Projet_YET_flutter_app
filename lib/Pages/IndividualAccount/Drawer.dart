import 'package:final_project/Pages/IndividualAccount/Oops.dart';

import 'package:final_project/widgets/LoginTab.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      surfaceTintColor: Colors.black45,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 238, 240, 235)),
              currentAccountPicture: CircleAvatar(),
              accountName: Text('something'),
              accountEmail: Text(('someone@emal.com'))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.person_32_regular),
                title: const Text('Account'),
                onTap: () {},
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
                leading: const Icon(FluentIcons.question_circle_32_regular),
                title: const Text('Explore'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Oopspage()));
                },
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                leading: const Icon(FluentIcons.lock_shield_48_regular),
                title: const Text('Privacy policy'),
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

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginTab()));
                },
              ))
        ],
      ),
    );
  }
}
