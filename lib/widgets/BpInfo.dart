import 'package:flutter/material.dart';

class BpInfo extends StatefulWidget {
  const BpInfo({super.key});

  @override
  _BpInfoState createState() => _BpInfoState();
}

class _BpInfoState extends State<BpInfo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController tabcontroller2 = TabController(length: 5, vsync: this);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TabBar(controller: tabcontroller2, isScrollable: true, tabs: const [
          Tab(
            text: 'Description',
          ),
          Tab(
            text: 'Services',
          ),
          Tab(
            text: 'Working Hours',
          ),
          Tab(
            text: 'Reviews',
          ),
          Tab(
            text: 'Photos',
          )
        ])
      ],
    );
  }
}
