import 'package:flutter/material.dart';

class Oopspage extends StatefulWidget {
  const Oopspage({super.key});

  @override
  _OopspageState createState() => _OopspageState();
}

class _OopspageState extends State<Oopspage> {
  String selectedValue = 'Addis Ababa';
  final List<String> countries = [
    'Addis Ababa',
    'Bahir dar',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose city',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text('about your current location,',
                    style: TextStyle(fontWeight: FontWeight.normal))),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text('Would you like to explore other cities',
                    style: TextStyle(fontWeight: FontWeight.normal))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: DropdownButton(
                  value: selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: countries
                      .map((String countries) => DropdownMenuItem(
                            value: countries,
                            child: Text(countries),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                )),
            /*  ElevatedButton(
                onPressed: () {
                  if (selectedValue == countries[0]) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => addisababa()));
                  }
                  if (selectedValue == countries[1]) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => mainPage()));
                  }
                },
                child: Text('Go'))*/
          ],
        ),
      ),
    );
  }
}
