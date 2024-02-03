import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:get_time_ago/get_time_ago.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String text = loremIpsum(words: 20, initWithLorem: true);
  List<DocumentSnapshot> message = [];
  TextEditingController _message = TextEditingController();
  Map<String, dynamic> argument = Get.arguments as Map<String, dynamic>;
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  String? time;

  @override
  Widget build(BuildContext context) {
    String proPic = argument['propic'].toString();
    String buzName = argument['buzName'].toString();
    String bid = argument['bid'].toString();
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(
            255,
            238,
            240,
            235,
          )),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Business Accounts Requests")
                  .doc(_auth)
                  .snapshots(),
              builder: (context, snapshot) {
                return Container(
                  height: 130,
                  color: const Color.fromARGB(
                    255,
                    238,
                    240,
                    235,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data!["coverPhoto"]),
                            radius: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, right: 70),
                          child: Text(
                            snapshot.data!["Business Name"],
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Business Accounts Requests")
                    .doc(bid)
                    .collection("message")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    message = snapshot.data!.docs;
                  }
                  return ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            width: 400,
                            child: GestureDetector(
                              onTap: () {
                                // Get.to(() => buzpage(),
                                //     arguments: annoucmnet[index]
                                //         ["bid"]);
                              },
                              child: Card(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: const Color.fromARGB(255, 238, 240, 235),
                                elevation: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SizedBox(
                                            width: 255,
                                            child: Text(
                                              message[index]["message"],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.more_horiz_sharp))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 8, 0, 10),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                message[index]["profilePic"]
                                                    .toString()),
                                            radius: 18,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: getTime(
                                              message[index]["timestamp"]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
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
