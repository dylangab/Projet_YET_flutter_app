import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/widgets/LoginTab.dart';
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
  String? time;

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 130,
            color: const Color.fromARGB(
              255,
              238,
              240,
              235,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CircleAvatar(
                      radius: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, right: 70),
                    child: Text(
                      "Ras Coffee",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("message")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    message = snapshot.data!.docs;
                  }
                  return ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Icon(
                                    Icons.timer,
                                    size: 15,
                                  ),
                                ),
                                getTime(message[index]['timestamp'].toString())
                                /*    Padding(
                                  padding:
                                      const EdgeInsets.only(top: 30, left: 5),
                                  child: Text(
                                    time = getTime(message[index]['timestamp']
                                            .toString())
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )*/
                                ,
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Card(
                                  color: const Color.fromARGB(
                                    255,
                                    238,
                                    240,
                                    235,
                                  ),
                                  elevation: 8,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      message[index]["message"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
          SizedBox(
            child: TextField(
              controller: _message,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance.collection('message').add({
                    'message': _message.value.text,
                    'timestamp': "${DateTime.now()}"
                  });
                },
                child: const Text("post")),
          )
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
