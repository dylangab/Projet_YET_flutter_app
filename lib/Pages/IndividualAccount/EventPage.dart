import 'package:final_project/Pages/IndividualAccount/showOnMap.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../../models/getX.dart';

class eventpage extends StatefulWidget {
  const eventpage({super.key});

  @override
  _eventpageState createState() => _eventpageState();
}

class _eventpageState extends State<eventpage> {
  List<DocumentSnapshot> event = [];

  bool? value;

  int? counter = 0;
  List uidList = [];

  String text = loremIpsum(words: 10, initWithLorem: true);
  TextEditingController commentController = TextEditingController();
  FocusNode commentNode = FocusNode();
  final individualAccountFetch controller = Get.put(individualAccountFetch());
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Events").snapshots(),
            builder: (context, snapshot) {
              print(snapshot.data);

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                event = snapshot.data!.docs;
              }

              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: event.length,
                  itemBuilder: ((context, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    event[index]["image"],
                                  ))),
                        ),
                        const Positioned(
                          top: 50,
                          right: 30,
                          child: CircleAvatar(
                            radius: 15,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3)),
                            width: 300,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Event Name :- ${event[index]["eventName"]}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      event[index]["eventDescription"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Event Address:- addis abeba ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const ShowOnMap(),
                                          arguments: event[index]
                                              ["coodinates"]);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 66, 106, 90),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 66, 106, 90))),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Text(
                                            "show location on map >",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              width: 85,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        /* Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: IconButton(
                                              onPressed: () {
                                                uidList.addAll(
                                                    event[index]["likedUids"]);
                                                uid = event[index]["uid"]
                                                    .toString()
                                                    .trim();
                                                uidChecker();
                                                likeButtonUpdater();
                                              },
                                              icon: const Icon(
                                                  Icons.thumb_up_alt_sharp)),
                                        ),*/
                                        Text(
                                            "(${event[index]["likedUids"].length})")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showBottomSheet(
                                                  enableDrag: true,
                                                  elevation: 5,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SizedBox(
                                                        height: 500,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 400,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount: event[
                                                                            index]
                                                                        [
                                                                        "comments"]
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        CommentIndex) {
                                                                  if (event[index]
                                                                              [
                                                                              "comments"]
                                                                          .length ==
                                                                      0) {
                                                                    return Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: const Text(
                                                                          "No comments yet..."),
                                                                    );
                                                                  } else {
                                                                    var comments =
                                                                        event[index]["comments"]
                                                                            [
                                                                            CommentIndex];
                                                                    var userAvatar =
                                                                        event[index]["userName"]
                                                                            [
                                                                            CommentIndex];
                                                                    return Container(
                                                                      margin:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                              border: Border(bottom: BorderSide(width: 1, color: Colors.black38))),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            SizedBox(
                                                                          child: Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                CircleAvatar(
                                                                                  child: Text(userAvatar),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    width: 250,
                                                                                    child: Text(
                                                                                      comments,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          250,
                                                                      child:
                                                                          TextField(
                                                                        focusNode:
                                                                            commentNode,
                                                                        controller:
                                                                            commentController,
                                                                        decoration:
                                                                            InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15),
                                                                      child: ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: const Color.fromARGB(255, 229, 143, 101)),
                                                                          onPressed: () {
                                                                            addComment(event[index]["uid"].toString().trim(),
                                                                                event[index]['userName']);
                                                                          },
                                                                          child: const Text("submit")),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.comment_bank,
                                              color: Colors.black,
                                            )),
                                        Text(
                                          "(${event[index]["comments"].length})",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  }));
            }));
  }

  Future<void> addComment(uid, userList) async {
    List userName = uidList;

    userName.add(controller.userName.value[0]);
    FirebaseFirestore.instance.collection('Events').doc(uid).update({
      'comments': FieldValue.arrayUnion([commentController.value.text]),
      'userName': userName
    });
  }
}
