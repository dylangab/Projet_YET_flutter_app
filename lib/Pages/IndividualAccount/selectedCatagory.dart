import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BusinessAccount/buzpage1.dart';

class SelectedCatagoryPage extends StatefulWidget {
  const SelectedCatagoryPage({super.key});

  @override
  State<SelectedCatagoryPage> createState() => _SelectedCatagoryPageState();
}

class _SelectedCatagoryPageState extends State<SelectedCatagoryPage> {
  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> selectedCatagory = [];
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Business Accounts Requests")
                  .where('businesscatagory', isEqualTo: '${Get.arguments}')
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot);

                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  selectedCatagory = snapshot.data!.docs;
                }

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await Get.to(() => buzpage(),
                              arguments: selectedCatagory[index]["bid"]);
                        },
                        child: SizedBox(
                          child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Stack(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(1),
                                  child: Text(''),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            selectedCatagory[index]["image"]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red,
                                  ),
                                  width: 150,
                                  height: 300,
                                ),
                                Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Text(
                                      '${selectedCatagory[index]["Business Name"]}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ])),
                        ),
                      );
                    });
              }),
        ),
      ],
    ));
  }
}
