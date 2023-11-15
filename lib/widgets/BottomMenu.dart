import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ButtomMenu extends StatefulWidget {
  const ButtomMenu({super.key});

  @override
  _ButtomMenuState createState() => _ButtomMenuState();
}

class _ButtomMenuState extends State<ButtomMenu> {
  final int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.redAccent,
            gap: 8,
            padding: EdgeInsets.all(5),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.menu,
                text: 'Catagory',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Annoucments',
              ),
              GButton(
                icon: Icons.event,
                text: 'Events',
              ),
            ]),
      ),
    );

    /*FlashyTabBar(
        items: [
          FlashyTabBarItem(
              icon: const Icon(
                Icons.home,
              ),
              title: const Text('Home')),
          FlashyTabBarItem(
              icon: const Icon(Icons.menu), title: const Text('Caregory')),
          FlashyTabBarItem(
              icon: const Icon(Icons.event), title: const Text('Events')),
          FlashyTabBarItem(
              icon: const Icon(Icons.notifications),
              title: const Text('Notification')),
        ],
        animationCurve: Curves.bounceIn,
        selectedIndex: _selectedindex,
        showElevation: false,
        iconSize: 20,
        height: 60,
        onItemSelected: (index) {
          setState(() {
            _selectedindex = index;
          });
        }
        )
        ;*/
  }
}
