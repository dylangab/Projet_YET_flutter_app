import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:final_project/models/models.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  bool selected = false;
  final List<ItemModel> chiplist = [
    ItemModel("Hotel", Colors.blueGrey, false),
    ItemModel("Cafe", Colors.blueGrey, false),
    ItemModel("Game zone", Colors.blueGrey, false),
    ItemModel("Beauty salon", Colors.blueGrey, false),
    ItemModel("barbor shop", Colors.blueGrey, false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text('Choose your Interests'),
              ),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: filterChipsList(),
              ),
            ],
          ),
        ));
  }

  List<Widget> filterChipsList() {
    List<Widget> chips = [];
    for (int i = 0; i < chiplist.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          label: Text(chiplist[i].label),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
          backgroundColor: chiplist[i].color,
          selected: chiplist[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              chiplist[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
