import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../IndividualAccount/MessagePage.dart';
import '../IndividualAccount/showOnMap.dart';

class buzpage extends StatefulWidget {
  buzpage({
    super.key,
  });

  @override
  _buzpageState createState() => _buzpageState();
}

class _buzpageState extends State<buzpage> with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> annoucmnet = [];
  List<double> ratingList = [];
  List<String> UserIdList = [];
  bool visability = false;
  double? Rating;
  double? sumRating;
  String? devicetoken;
  List<double> flutterlist = [];
  double? average;
  String _text = loremIpsum(words: 60, initWithLorem: true);
  List<Map<String, dynamic>> businessHoursList = [];
  bool? checker;
  bool? idCheck;
  bool rateCheck = true;
  String? bid;
  @override
  void initState() {
    super.initState();
    bid = Get.arguments;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();

    final TabController tabcontroller3 = TabController(length: 3, vsync: this);
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Business Accounts Requests")
                .doc(bid)
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);

              checkUid(FirebaseAuth.instance.currentUser!.uid.toString().trim(),
                  snapshot.data!["followerIdList"]);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromARGB(255, 238, 240, 235),
                    child: Stack(fit: StackFit.loose, children: [
                      Positioned(
                          child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot.data!["coverPhoto"]))),
                        height: 130,
                      )),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              Get.to(() => const MessagePage(), arguments: {
                                'propic': snapshot.data!["profile_Pic"],
                                'buzName': snapshot.data!["Business Name"],
                                'bid': snapshot.data!["bid"]
                              });
                            },
                            icon: const Icon(Icons.message_sharp,
                                color: Color.fromARGB(255, 229, 143, 101)),
                          )),
                      Positioned(
                          top: 100,
                          left: 30,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data!["profile_Pic"]),
                                radius: 50,
                              ),
                              SizedBox(
                                height: 65,
                                width: 250,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                      snapshot.data!["Business Name"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          )),
                    ]),
                  ),
                  Container(
                    height: 70,
                    color: const Color.fromARGB(255, 238, 240, 235),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            alignment: Alignment.centerRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Icon(
                                          Icons.star_rate,
                                          color: Colors.yellow,
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          snapshot.data!['rating'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ],
                                ),
                                FutureBuilder(
                                  future: raterUid(
                                      _auth.toString().trim(),
                                      snapshot.data!["rateUids"],
                                      snapshot.data!["bid"]),
                                  builder: (context, snapshots) {
                                    if (snapshots.connectionState ==
                                        ConnectionState.done) {
                                      // The asynchronous operations are complete
                                      return Visibility(
                                        maintainState: true,
                                        visible: rateCheck,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0),
                                                child: IconButton(
                                                    onPressed: () {
                                                      print("rate");
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Give rate"),
                                                            content: RatingBar
                                                                .builder(
                                                              initialRating: 1,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                Rating = rating;
                                                                print(Rating);
                                                              },
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    double
                                                                        rating;
                                                                    String bid =
                                                                        await snapshot
                                                                            .data!['bid'];
                                                                    print(bid);
                                                                    await updateRatingList(
                                                                        bid,
                                                                        Rating!,
                                                                        snapshot
                                                                            .data!['ratingList']);
                                                                    rating = await calculateAverageRating(
                                                                        snapshot
                                                                            .data!["ratingList"]);
                                                                    print(
                                                                        rating);

                                                                    await submitRating(
                                                                        rating,
                                                                        bid);
                                                                    await updateRateUidList(
                                                                        bid,
                                                                        _auth
                                                                            .toString()
                                                                            .trim(),
                                                                        snapshot
                                                                            .data!["rateUids"]);
                                                                  },
                                                                  child: const Text(
                                                                      "Submit"))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.star_border))),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                child: Text(
                                                  "Rate this",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                          ],
                                        ),
                                      ); // Use snapshot.data with a fallback value
                                    } else {
                                      // The asynchronous operations are still in progress
                                      return const Center(
                                          child:
                                              CircularProgressIndicator()); // You can show a loading indicator here
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 100, 0),
                                          child: Text(
                                            "(${snapshot.data!["followerIdList"].length})",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400),
                                          )),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 100, 0),
                                          child: Text(
                                            'Followers',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 229, 143, 101)),
                        ),
                        onPressed: () async {
                          if (idCheck == false) {
                            await FirebaseFirestore.instance
                                .collection("Business Accounts Requests")
                                .doc("${Get.arguments}")
                                .update(
                              {
                                'followerIdList': FieldValue.arrayUnion([
                                  FirebaseAuth.instance.currentUser!.uid
                                      .toString()
                                ])
                              },
                            );
                          } else if (idCheck == true) {
                            await FirebaseFirestore.instance
                                .collection("Business Accounts Requests")
                                .doc("${Get.arguments}")
                                .update(
                              {
                                'followerIdList': FieldValue.arrayRemove([
                                  FirebaseAuth.instance.currentUser!.uid
                                      .toString()
                                ])
                              },
                            );
                          } else {
                            print("user already following");
                          }
                        },
                        child: checkUid(
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString()
                                    .trim(),
                                snapshot.data!["followerIdList"])
                            ? const Text(
                                'Following',
                                style: TextStyle(color: Colors.white),
                              )
                            : const Text(
                                'Follow',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TabBar(
                              padding: const EdgeInsets.all(10),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              controller: tabcontroller3,
                              isScrollable: true,
                              indicatorColor:
                                  const Color.fromARGB(255, 145, 116, 102),
                              indicatorWeight: 1,
                              indicatorPadding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              tabs: const [
                                Tab(
                                  text: 'About Us',
                                ),
                                Tab(
                                  text: 'Reviews',
                                ),
                                Tab(
                                  text: 'Images',
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 448,
                    child: TabBarView(
                      controller: tabcontroller3,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Text(
                                  snapshot.data!["description"],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                child: Text(
                                  "Service",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Text(
                                  snapshot.data!["service"],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                child: Text(
                                  "Business Hours",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Day')),
                                    DataColumn(label: Text('Opens')),
                                    DataColumn(label: Text('Closes')),
                                  ],
                                  rows: businessHoursList.map((dayData) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(dayData['Day'])),
                                        DataCell(
                                            Text(dayData['Data']['Opens'])),
                                        DataCell(
                                            Text(dayData['Data']['Closes'])),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                child: Text(
                                  "Additional Infromation",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "webite:- ${snapshot.data!["website"]} ",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Address:- ${snapshot.data!["Business Address"]}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ShowOnMap(), arguments: {
                                    'latitude': snapshot.data!["profile_Pic"],
                                    'longitude':
                                        snapshot.data!["Business Name"],
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 30),
                                  child: Container(
                                    height: 40,
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "show location on map >",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 66, 106, 90),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 66, 106, 90))),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                child: Text(
                                  "Owner's Infromation",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Full Name:-${snapshot.data!["First Name"]} ${snapshot.data!["Last Name"]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 50),
                                  child: Text(
                                    "Phone No:- ${snapshot.data!["Phone Number"]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(children: [
                            SizedBox(
                              height: 300,
                              child: check(snapshot.data!["reviews"])
                                  ? ListView.builder(
                                      itemCount:
                                          snapshot.data!["reviews"].length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          width: 400,
                                          child: Card(
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            color: const Color.fromARGB(
                                                255, 238, 240, 235),
                                            elevation: 8,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: getTime(snapshot
                                                            .data!['reviews']
                                                                ['timestamp']
                                                            .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      snapshot.data!["reviews"]
                                                          ['review'][index],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      child: const Center(
                                        child: Text("No Reviews Yet...."),
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Form(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'write a comment',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 20, 10),
                                              child: SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  controller: comment,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)))),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        "Business Accounts Requests")
                                                    .doc("${Get.arguments}")
                                                    .update({
                                                  /* 'commentBy':
                                                      FieldValue.arrayUnion([
                                                    FirebaseAuth
                                                        .instance.currentUser!.uid
                                                  ]),*/
                                                  'reviews': {
                                                    'review':
                                                        FieldValue.arrayUnion([
                                                      comment.value.text
                                                    ]),
                                                    'timestamp':
                                                        "${DateTime.now()}"
                                                  }
                                                });
                                              },
                                              child:
                                                  const Text('Submit comment'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: visability,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  child: RatingBar.builder(
                                                    initialRating: 1,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      Rating = rating;
                                                      print(Rating);
                                                    },
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              229,
                                                              143,
                                                              101),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  child: const Text("submit"),
                                                  onPressed: () {},
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                            ),
                          ]),
                        ),
                        SizedBox(
                            child: check(snapshot.data!["photos"])
                                ? GridView.builder(
                                    itemCount: snapshot.data!["photos"].length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        snapshot.data!["photos"][index],
                                        fit: BoxFit.fill,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text("No Photos Yet...."),
                                  ))
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  Widget buildcommentSection() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Business Account Requests')
            .doc("${Get.arguments}")
            .collection("comments")
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Text("No Reviews yet");
          } else {
            annoucmnet = snapshot.data!.docs;
          }

          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child:
                                Text(annoucmnet[index]['Comment'].toString()),
                          ),
                        ),
                      ],
                    ));
              });
        });
  }

  void getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      devicetoken = await messaging.getToken();
      print(devicetoken);
    } catch (e) {
      print("error getting token");
    }
  }

  Future<void> userRateList() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc("${Get.arguments}");

    await docRef.update({
      "ratingList": FieldValue.arrayUnion(Rating as List),
    });
  }

  Future<List<double>> fetchList() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc('"${Get.arguments}"');
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      List<dynamic> firestoreArray = doc['${Get.arguments}'];
      flutterlist = firestoreArray.cast<double>();
      return flutterlist;
    } else {
      print("Document doesnt exist");
      return [];
    }
  }

  Future<double> calculateAverageRating(List snapshot) async {
    List rate = await snapshot;
    double sum = rate.reduce((a, b) => a + b);
    average = sum / rate.length;
    return average!;
  }

  Future<void> submitRating(double rating, String uid) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(uid);

    await docRef.update({
      "rating": rating,
    }).then((value) => FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(uid)
            .update({
          'rateUids': FieldValue.arrayUnion([uid]),
        }));
  }

  Future<void> updateRatingList(
      String uid, double rating, List snapshot) async {
    List rateList = snapshot;
    rateList.add(rating);

    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(uid);

    await docRef.update({
      "ratingList": rateList,
    });
  }

  Future<void> updateRateUidList(String bid, String uid, List snapshot) async {
    List uidList = snapshot;
    uidList.add(uid);

    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(bid);

    await docRef.update({
      "rateUids": uidList,
    });
  }

  Future<void> fetchRatingList() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Business_catagory')
        .doc("${Get.arguments}")
        .get();
    if (doc.exists) {
      ratingList = (doc['catagories'] as List<dynamic>).cast<double>();
      for (var item in ratingList) {
        print(item);
      }
    }
  }

  Future<void> fetchUserIdList() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Business_catagory')
        .doc("${Get.arguments}")
        .get();
    if (doc.exists) {
      UserIdList = (doc['catagories'] as List<dynamic>).cast<String>();
      for (var item in UserIdList) {
        print(item);
      }
    }
  }

  void ratingVsiabilityChecker() {
    if (!UserIdList.contains("${Get.arguments}")) {
      visability = true;
    }
  }

  bool checkUid(String uid, List followers) {
    if (followers.contains(uid.trim())) {
      idCheck = true;
    } else {
      idCheck = false;
    }
    return idCheck!;
  }

  bool check(List snapshot) {
    if (snapshot.isEmpty) {
      checker = false;
    } else if (snapshot.isNotEmpty) {
      checker = true;
    }
    return checker!;
  }

  Future<bool> raterUid(
      String snapshotuid, List snapshotrateUids, String snapshotbid) async {
    bool visable;
    List uids = snapshotrateUids;
    String uid = snapshotuid;

    if (uids.contains(uid)) {
      visable = false;
    } else {
      visable = true;
    }
    rateCheck = visable;

    return rateCheck;
  }

  Future<String> getBid() async {
    bid = await Get.arguments;
    return bid!;
  }

  Future<void> fetchData() async {
    try {
      String userId = bid!; // Assuming `_auth` is your authentication instance.
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Business Accounts Requests')
          .doc(userId)
          .collection('bussiness_Hours')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> businessHoursMap = snapshot.data()!;
        businessHoursList = businessHoursMap.entries.map((entry) {
          return {'Day': entry.key, 'Data': entry.value};
        }).toList();
        setState(() {}); // Trigger a rebuild after fetching the data
      } else {
        // Handle the case where the document doesn't exist.
      }
    } catch (e) {
      // Handle any errors that occurred during the fetch.
      print("Error fetching business hours: $e");
    }
  }

  Widget getTime(String snaphot) {
    String serverTime = snaphot;

    var time = DateTime.parse(serverTime);
    var result = GetTimeAgo.parse(time);

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5),
      child: Text(
        result,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
      ),
    );
  }
}
