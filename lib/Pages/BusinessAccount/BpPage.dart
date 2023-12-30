import 'dart:io';

import 'package:final_project/Pages/BusinessAccount/Drawer.dart';
import 'package:final_project/Pages/BusinessAccount/chooseLocation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import '../../models/getX.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class BpPage extends StatefulWidget {
  const BpPage({super.key});

  @override
  _BpPageState createState() => _BpPageState();
}

class _BpPageState extends State<BpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String text = loremIpsum(words: 15, initWithLorem: true);
  int index = 0;
  int index1 = 0;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _annoucment = TextEditingController();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _annoucmentNode = FocusNode();
  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _eventCatagory = TextEditingController();
  final TextEditingController _eventDescription = TextEditingController();
  final FocusNode _eventNameNode = FocusNode();
  final FocusNode _eventCatagoryNode = FocusNode();
  final FocusNode _eventNodeDescription = FocusNode();
  final GetMapController controller = Get.put(GetMapController());
  List tokenList = [];
  List<String> userIdList = [];
  String? photoUrl;
  String? _coordinateText;
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageUrlList = [];
  XFile? file;
  bool? imagechecker;
  bool? checker;

  void dispose() {
    _annoucment.dispose();
    _eventCatagory.dispose();
    _eventDescription.dispose();
    _eventName.dispose();
    _title.dispose();
    _annoucmentNode.dispose();
    _eventCatagoryNode.dispose();
    _titleNode.dispose();
    _annoucmentNode.dispose();
    _eventNodeDescription.dispose();
    _eventNameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Business Accounts Requests")
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          return Scaffold(
            drawer: const BuzDraer(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data!["profile_Pic"]),
                                radius: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  snapshot.data!["Business Name"],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 192,
                              height: 70,
                              decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                      top: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                      end: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!["rating"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Icon(
                                        Icons.star_rate,
                                        color: Colors.yellow,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 192,
                              height: 70,
                              decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                      top: BorderSide(color: Colors.black26),
                                      bottom: BorderSide(color: Colors.black26),
                                      end: BorderSide(color: Colors.black26))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        snapshot.data!['followerIdList'].length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: const Text("Post"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 229, 143, 101),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 229, 143, 101),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text("Reviews"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 229, 143, 101),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text("Photos"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: IndexedStack(index: index, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        child: ListView(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          index1 = 0;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 238, 240, 235),
                                        ),
                                      )),
                                      child: const Text(
                                        "Post Event",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 229, 143, 101)),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          index1 = 1;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 238, 240, 235),
                                        ),
                                      )),
                                      child: const Text(
                                        "Post Annoucment",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 229, 143, 101)),
                                      ),
                                    )),
                              ],
                            ),
                            IndexedStack(
                              index: index1,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 590,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 238, 240, 235))),
                                    child: Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 0, 10),
                                            child: Text(
                                              'Event Name',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 30, 10),
                                            child: TextFormField(
                                              focusNode: _eventNameNode,
                                              validator: (value) {
                                                String? message;
                                                if (value!.isEmpty) {
                                                  message =
                                                      "Event Name should not be empty";
                                                }
                                                return message;
                                              },
                                              cursorColor: const Color.fromARGB(
                                                  255, 66, 106, 90),
                                              controller: _eventName,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 66, 106, 90)),
                                                  )),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 0, 10),
                                            child: Text(
                                              'Event Description',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 30, 10),
                                            child: TextFormField(
                                              focusNode: _eventNodeDescription,
                                              validator: (value) {
                                                String? message;
                                                if (value!.isEmpty) {
                                                  message =
                                                      "Event description should not be empty";
                                                }
                                                return message;
                                              },
                                              cursorColor: const Color.fromARGB(
                                                  255, 66, 106, 90),
                                              controller: _eventDescription,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 66, 106, 90)),
                                                  )),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 21, left: 15),
                                            child: Text(
                                              'Location',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 66, 106, 90))),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                            _coordinateText
                                                                .toString()),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                const ChooseLocationPage());
                                                            coordinateToText();
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                            Icons.map_sharp,
                                                            color: Colors.black,
                                                            size: 20,
                                                          )),
                                                    ]),
                                              )),
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 0, 0),
                                            child: Text(
                                              'Add photos',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Center(
                                              child: imageCheck(file)
                                                  ? Material(
                                                      elevation: 3,
                                                      child: Image.file(
                                                        File(file!.path),
                                                        fit: BoxFit.fill,
                                                        height: 130,
                                                        width: 100,
                                                      ))
                                                  : Material(
                                                      elevation: 3,
                                                      child: Container(
                                                        width: 100,
                                                        height: 130,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              238,
                                                              240,
                                                              235),
                                                        ),
                                                        child: Center(
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                ImagePicker
                                                                    imagePicker =
                                                                    ImagePicker();
                                                                file = await imagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                                print(
                                                                    '${file?.path}');
                                                                String
                                                                    filename =
                                                                    DateTime.now()
                                                                        .microsecondsSinceEpoch
                                                                        .toString();

                                                                Reference
                                                                    reference =
                                                                    FirebaseStorage
                                                                        .instance
                                                                        .ref();
                                                                Reference
                                                                    referenceimage =
                                                                    reference.child(
                                                                        'images');
                                                                Reference
                                                                    referenceupload =
                                                                    referenceimage
                                                                        .child(
                                                                            filename);
                                                                try {
                                                                  await referenceupload
                                                                      .putFile(File(
                                                                          file!
                                                                              .path));
                                                                  photoUrl =
                                                                      await referenceupload
                                                                          .getDownloadURL();
                                                                } catch (e) {}
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(Icons
                                                                  .add_a_photo)),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Center(
                                              child: SizedBox(
                                                width: 150,
                                                height: 40,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    String propic =
                                                        await snapshot.data![
                                                            "profile_Pic"];
                                                    LatLng coordinate = LatLng(
                                                        controller.coordinates!
                                                            .value.latitude,
                                                        controller.coordinates!
                                                            .value.longitude);

                                                    String bid =
                                                        _auth.currentUser!.uid;

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Events')
                                                        .doc(_auth
                                                            .currentUser!.uid)
                                                        .set({
                                                      'bid': bid,
                                                      'eventName':
                                                          _eventName.value.text,
                                                      'eventDescription':
                                                          _eventDescription
                                                              .value.text,
                                                      'profilePic': propic,
                                                      'photoUrl': photoUrl,
                                                      'comments': [],
                                                      'likeduid': [],
                                                      'coodinates': {
                                                        'latitude':
                                                            coordinate.latitude,
                                                        'longitude':
                                                            coordinate.longitude
                                                      },
                                                      'address': _coordinateText
                                                          .toString(),
                                                    });
                                                  },
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
                                                                          15))),
                                                  child: const Text("Post"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 238, 240, 235))),
                                    child: Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 0, 10),
                                            child: Text(
                                              'Title',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 30, 10),
                                            child: TextFormField(
                                              focusNode: _titleNode,
                                              validator: (value) {
                                                String? message;
                                                if (value!.isEmpty) {
                                                  message =
                                                      "Title should not be empty";
                                                }
                                                return message;
                                              },
                                              cursorColor: const Color.fromARGB(
                                                  255, 66, 106, 90),
                                              controller: _title,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          66,
                                                                          106,
                                                                          90))),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 66, 106, 90)),
                                                  )),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 21, left: 15),
                                            child: Text(
                                              'Annoucment',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 30, 10),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1.5,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              66,
                                                              106,
                                                              90))),
                                              child: TextFormField(
                                                  focusNode: _annoucmentNode,
                                                  validator: (value) {
                                                    String? message;
                                                    if (value!.isEmpty) {
                                                      message =
                                                          "Annoucment should not be empty";
                                                    }
                                                    return message;
                                                  },
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 66, 106, 90),
                                                  controller: _annoucment,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none))),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              height: 40,
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  String propic = await snapshot
                                                      .data!["profile_Pic"];
                                                  String buzname =
                                                      await snapshot.data![
                                                          'Business Name'];
                                                  String bid = await _auth
                                                      .currentUser!.uid;
                                                  int followers = await snapshot
                                                      .data!['followerIdList']
                                                      .length;

                                                  if (followers == 0) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Atleast 1 follower is required to send annoucment"),
                                                    ));
                                                  } else {
                                                    await getUserId(_auth
                                                            .currentUser!.uid)
                                                        .then((value) {
                                                      for (var followerId
                                                          in value) {
                                                        saveMessageindi(
                                                            followerId,
                                                            propic,
                                                            buzname,
                                                            bid);
                                                      }
                                                    });

                                                    await saveMessageBp(
                                                        _auth.currentUser!.uid);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 229, 143, 101),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                child: const Text("Post"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 21),
                      child: SizedBox(
                        height: 300,
                        child: check(snapshot.data!["reviews"])
                            ? ListView.builder(
                                itemCount: snapshot.data!["reviews"].length,
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
                                                  CrossAxisAlignment.start,
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
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Sara chakamola",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text("No Reviews Yet...."),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 21),
                              child: GestureDetector(
                                onTap: () async {
                                  await muiltiImageSelector();
                                  for (var file in imageFileList!) {
                                    uploadToCloudStorage(file);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.5,
                                          color: const Color.fromARGB(
                                              255, 229, 143, 101))),
                                  height: 40,
                                  width: 130,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 15,
                                          ),
                                          Text("Add Photos")
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                child: check(snapshot.data!["photos"])
                                    ? GridView.builder(
                                        itemCount:
                                            snapshot.data!["photos"].length,
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
                                      )),
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void getTokenList() async {
    await FirebaseFirestore.instance
        .collection('Business Account Requests')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("followers")
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                  tokenList.add(doc["deviceToken"]);
                }));
  }

  Future<List> getUserId(String bid) async {
    await FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(bid)
        .get()
        .then((value) => userIdList = value.get('followerIdList'));
    return userIdList;
  }

  Future<void> saveMessageindi(
      followerId, String profilePic, String businessName, String bid) async {
    await FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(followerId)
        .collection('messages')
        .add({
      'senderName': businessName,
      'bid': bid,
      'profilePic': profilePic,
      'timestamp': DateTime.now(),
      'message': _annoucment.value.text,
      'title': _title.value.text,
      'status': "unseen"
    });
  }

  Future<void> saveMessageBp(String bid) async {
    await FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(_auth.currentUser!.uid)
        .collection('My_messages')
        .add({
      'timestamp': DateTime.now(),
      'message': _annoucment.value.text,
      'title': _title.value.text,
    });
  }

  void coordinateToText() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      controller.coordinates!.value.latitude,
      controller.coordinates!.value.longitude,
      localeIdentifier: 'en',
    );

    Placemark placemark = placemarks.first;
    setState(() {
      _coordinateText = " ${placemark.locality}, ${placemark.country}, ";
    });
  }

  Future muiltiImageSelector() async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
  }

  void uploadToCloudStorage(file) async {
    String imageurl;
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceimage = reference.child('images');
    Reference referenceupload = referenceimage.child(filename);
    try {
      await referenceupload.putFile(File(file!.path));
      imageurl = await referenceupload.getDownloadURL();
      imageUrlList.add(imageurl);
      FirebaseFirestore.instance
          .collection("Business Accounts Requests")
          .doc("4u3NEAlS8CZOfc7c08j2yRtJjxt2")
          .update({
        'photos': FieldValue.arrayUnion([imageurl])
      });
    } catch (e) {}
  }

  bool imageCheck(XFile? image) {
    if (image != null) {
      imagechecker = true;
    } else {
      imagechecker = false;
    }
    return imagechecker!;
  }

  bool check(List snapshot) {
    if (snapshot.isEmpty) {
      checker = false;
    } else if (snapshot.isNotEmpty) {
      checker = true;
    }
    return checker!;
  }
}
