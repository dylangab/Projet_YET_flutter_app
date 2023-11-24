import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  @override
  void initState() {
    super.initState();
    fetchInterest();
  }

  bool selected = false;
  List<String> _interestList = [];
  final List<ItemModel> chiplist = [
    ItemModel("Hotel", Colors.blueGrey, false),
    ItemModel("Cafe", Colors.blueGrey, false),
    ItemModel("Game zone", Colors.blueGrey, false),
    ItemModel("Beauty salon", Colors.blueGrey, false),
    ItemModel("barbor shop", Colors.blueGrey, false),
  ];
  List<String> interests = [
    'Hotel',
    'Cafe',
    'Game zone',
    'Beauty salon',
    'barbor shop"'
  ];
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  List<String> selectedIntersts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: fetchInterest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Choose Your Interest',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 5.0,
                      children: _interestList.map((String interest) {
                        return FilterChip(
                          label: Text(interest),
                          selected: selectedIntersts.contains(interest),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedIntersts.add(interest);
                              } else {
                                selectedIntersts.remove(interest);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  Color.fromARGB(255, 229, 143, 101)),
                          onPressed: () {
                            uploadUserInterest(_auth);
                          },
                          child: Text("Save")),
                    )
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  void uploadUserInterest(String uid) {
    FirebaseFirestore.instance
        .collection("Individual Accounts")
        .doc(uid)
        .update({
      'userInterest': FieldValue.arrayUnion([selectedIntersts])
    });
  }

  Future<void> fetchInterest() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Business_catagory')
        .doc('0p0kRqz8hx5WmR2NTnUA')
        .get();
    if (doc.exists) {
      _interestList = (doc['catagories'] as List<dynamic>).cast<String>();
    }
  }
}
