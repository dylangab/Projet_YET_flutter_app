import 'package:final_project/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class businessPage extends StatefulWidget {
  businessPage({
    super.key,
  });

  @override
  _businessPageState createState() => _businessPageState();
}

class _businessPageState extends State<businessPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();

    final TabController tabcontroller3 = TabController(length: 3, vsync: this);
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Business Accounts Requests")
                .doc("6Miaw901Zt6jaaezgYxV")
                .snapshots(),
            builder: (context, snapshot) {
              print(snapshot);

              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 222,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Stack(fit: StackFit.loose, children: [
                      Positioned(
                          child: Container(
                        height: 150,
                        color: Colors.black,
                      )),
                      const Positioned(
                          top: 120,
                          left: 30,
                          child: CircleAvatar(
                            radius: 50,
                          )),
                    ]),
                  ),
                  Container(
                    height: 100,
                    color: Colors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  snapshot.data!["Business Name"].toString(),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 100, 0),
                                      child: Text(
                                        '(0)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5, 100, 0),
                                      child: Text(
                                        'Followers',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ))
                                ],
                              ),
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
                              )
                            ],
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Business Details',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TabBar(
                            controller: tabcontroller3,
                            isScrollable: true,
                            tabs: [
                              const Tab(
                                text: 'Description',
                              ),
                              const Tab(
                                text: 'Reviews',
                              ),
                              const Tab(
                                text: 'Give Comments',
                              ),
                            ])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      controller: tabcontroller3,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Description :',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  snapshot.data!["description"].toString(),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Services :',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  child: Text(
                                      snapshot.data!['service'].toString()),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Working hours :',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  child: Text(snapshot.data!['openinghours']
                                      .toString()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const reviews(),
                        Container(
                            child: Form(
                                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'write a comment',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 70, 10),
                              child: TextFormField(
                                controller: comment,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final FirebaseFirestore _firestore =
                                        FirebaseFirestore.instance;
                                    await _firestore
                                        .collection('Comment')
                                        .doc()
                                        .set({
                                      'comment': comment.value.text,
                                    });
                                  },
                                  child: const Text('Submit comment')),
                            )
                          ],
                        )))
                      ],
                    ),
                  )
                ],
              );
            }));
  }
}
