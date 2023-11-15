import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String text = loremIpsum(words: 20, initWithLorem: true);
  String? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(
            255,
            238,
            240,
            235,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 130,
            color: Color.fromARGB(
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
                      radius: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 70),
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
            height: 636,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21, left: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          color: Color.fromARGB(
                            255,
                            238,
                            240,
                            235,
                          ),
                          elevation: 8,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.timer,
                          size: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 5),
                        child: Text(
                          timeDate(''),
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String timeDate(String timestamp) {
    final DateTime dateTime = (timestamp as Timestamp).toDate();
    time = dateTime.toString();
    return time!;
  }
}
