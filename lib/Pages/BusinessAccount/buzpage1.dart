import 'package:final_project/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/widgets/MostRated.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../widgets/BpInfo.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

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
  String _text1 = loremIpsum(words: 60, initWithLorem: true);
  String _text3 = loremIpsum(words: 150, initWithLorem: true);
  bool? checker;
  bool? idCheck;
  bool rateCheck = true;
  String? bid;
  @override
  void initState() {
    super.initState();
    bid = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();

    final TabController tabcontroller3 = TabController(length: 3, vsync: this);
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Business Accounts Requests")
                .doc("${Get.arguments}")
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);
              checkUid(FirebaseAuth.instance.currentUser!.uid.toString().trim(),
                  snapshot.data!["followerIds"]);

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
                                image: NetworkImage(snapshot.data!["image"]))),
                        height: 130,
                      )),
                      Positioned(
                          top: 100,
                          left: 30,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Text(
                                    snapshot.data!["Business Name"].toString(),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
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
                            margin: EdgeInsets.only(left: 30),
                            alignment: Alignment.centerRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Icon(
                                          Icons.star_rate,
                                          color: Colors.yellow,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          '4/5',
                                          style: TextStyle(
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
                                                padding:
                                                    EdgeInsets.only(top: 0),
                                                child: IconButton(
                                                    onPressed: () {
                                                      print("rate");
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
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
                                                                    String uid =
                                                                        await snapshot
                                                                            .data!['bid'];
                                                                    print(uid);
                                                                    await updateRatingList(
                                                                        uid,
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
                                                                        uid);
                                                                  },
                                                                  child: Text(
                                                                      "Submit"))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                        Icons.star_border))),
                                            Padding(
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
                                      return Center(
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
                                          padding: EdgeInsets.fromLTRB(
                                              0, 20, 100, 0),
                                          child: Text(
                                            "(${snapshot.data!["followerIds"].length})",
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
                                'followerIds': FieldValue.arrayUnion([
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
                                'followerIds': FieldValue.arrayRemove([
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
                                snapshot.data!["followerIds"])
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
                                  _text,
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
                                  _text,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Table(
                                  children: const [
                                    TableRow(children: [
                                      Text(
                                        'Days',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text("Opening Hours",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      Text("Closing Hours",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Monday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Tuesday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Wednesday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Thursday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Friday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Saturnday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Sunday',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Text("1:00",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ]),
                                  ],
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
                                    "webite:- www.abc.com",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Address:- Addis Abeba",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const ShowOnMap(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 30),
                                  child: Container(
                                    height: 40,
                                    child: Align(
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
                                        color: Color.fromARGB(255, 66, 106, 90),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color.fromARGB(
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
                                    "Full Name:- Eren Yeager",
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
                                    "Phone No:- 0932323222",
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
                            Container(
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
                                                  const Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        child: Center(
                                                          child: Text(
                                                            "M",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: Text(
                                                          "Sara chakamola",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      snapshot.data!["reviews"]
                                                          [index],
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
                                      child: Center(
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
                                                  'reviews':
                                                      FieldValue.arrayUnion(
                                                          [comment.value.text]),
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
}
