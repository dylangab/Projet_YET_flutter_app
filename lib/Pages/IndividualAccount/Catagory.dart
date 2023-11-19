import 'package:final_project/Pages/IndividualAccount/SearchPage.dart';
import 'package:final_project/Pages/IndividualAccount/selectedCatagory.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../BusinessAccount/buzpage1.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  List<String> _catagoryList = ['All'];
  @override
  void initState() {
    super.initState();
    fetchCatagory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white, actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Get.to(() => const searchPage());
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
              ),
              color: const Color.fromARGB(255, 229, 143, 101),
            ),
          )
        ]),
        drawer: const Drawer(),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 21, horizontal: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 20),
                  child: Text(
                    "Catagories",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 12),
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: 350,
                      child: FutureBuilder(
                        future: fetchCatagory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // The asynchronous operations are complete
                            return ListView.builder(
                                padding: const EdgeInsets.all(0),
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () async {
                                        var data = await Get.to(
                                            () => const SelectedCatagoryPage(),
                                            arguments: _catagoryList[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          _catagoryList[index],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ));
                                }); // Use snapshot.data with a fallback value
                          } else {
                            // The asynchronous operations are still in progress
                            return Scaffold(
                                body: Center(
                                    child:
                                        CircularProgressIndicator())); // You can show a loading indicator here
                          }
                        },
                      )),
                ],
              ),
              Container(
                  height: 615,
                  color: const Color.fromARGB(255, 238, 240, 235),
                  child: FutureBuilder(
                    future: fetchCatagory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // The asynchronous operations are complete
                        return ListView.builder(
                            itemCount: _catagoryList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  var data = await Get.to(
                                      () => const SelectedCatagoryPage(),
                                      arguments: _catagoryList[index]);
                                },
                                child: ListTile(
                                    trailing: IconButton(
                                      icon: const Icon(
                                          Icons.arrow_right_alt_sharp),
                                      onPressed: () {},
                                    ),
                                    title: Text(_catagoryList[index])),
                              );
                            }); // Use snapshot.data with a fallback value
                      } else {
                        // The asynchronous operations are still in progress
                        return Scaffold(
                            body: Center(
                                child:
                                    CircularProgressIndicator())); // You can show a loading indicator here
                      }
                    },
                  )),
            ])));
  }

  Future<void> fetchCatagory() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Business_catagory')
        .doc('0p0kRqz8hx5WmR2NTnUA')
        .get();
    if (doc.exists) {
      _catagoryList = (doc['catagories'] as List<dynamic>).cast<String>();
    }
  }
}
