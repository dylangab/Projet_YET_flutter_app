import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BusinessAccount/buzpage1.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController search = TextEditingController();
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Color.fromARGB(255, 229, 143, 101),
            title: Card(
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search....",
                    border: OutlineInputBorder()),
                onChanged: (val) {
                  setState(() {
                    query = val;
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Business Accounts Requests")
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: query.isEmpty
                                ? Container(
                                    child: const Center(
                                        child: Text("Search any business")),
                                  )
                                : ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshots.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      if (data["Business Name"]
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(query.toLowerCase())) {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await Get.to(() => buzpage(),
                                                      arguments: data["bid"]);
                                                },
                                                child: ListTile(
                                                    shape:
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            side:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      238,
                                                                      240,
                                                                      235),
                                                            )),
                                                    title: Text(
                                                      data["Business Name"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }));
                  }))
        ],
      ),
    );
  }
}
