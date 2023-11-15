import 'package:flutter/material.dart';
import 'package:final_project/widgets/BottomMenu.dart';
import 'package:final_project/widgets/BpInfo.dart';

class BusinessProPage extends StatefulWidget {
  const BusinessProPage({super.key});

  @override
  _BusinessProPageState createState() => _BusinessProPageState();
}

class _BusinessProPageState extends State<BusinessProPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ButtomMenu(),
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  color: Colors.red,
                )),
            Positioned(
              top: 0,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
            ),
            const Positioned(top: 5, right: 10, child: CircleAvatar()),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Text(
                            'Business Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 8, 0, 0),
                              child: Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.yellow,
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                              child: Text(
                                'Rating',
                                style: TextStyle(fontSize: 15),
                              )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: BpInfo())
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
