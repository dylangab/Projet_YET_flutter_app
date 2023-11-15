import 'package:final_project/widgets/bpinfo/workinghours.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class editbzupro extends StatefulWidget {
  const editbzupro({super.key});

  @override
  State<editbzupro> createState() => _editbzuproState();
}

class _editbzuproState extends State<editbzupro> {
  final _Key = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference profile =
      FirebaseFirestore.instance.collection('Business Accounts Request');

  String selectedValue = 'hotel';
  String selectedValue1 = 'Addis Ababa';
  final List<String> city = [
    'Addis Ababa',
    'Bahir dar',
  ];
  final List<String> catagory = [
    'barbor',
    'hotel',
    'educational',
    'hair salon',
    'resturants'
  ];
  Future<void> editprofile() {
    return profile.doc(_auth.currentUser!.uid).set({
      'firstname': _Key.currentState!.fields['FirstName']!.value.toString(),
      'lastname': _Key.currentState!.fields['LastName']!.value.toString(),
      'email': _Key.currentState!.fields['Email']!.value.toString(),
      'password': _Key.currentState!.fields['password']!.value.toString(),
      'phoneno': _Key.currentState!.fields['PhoneNo']!.value.toString(),
      'businessname':
          _Key.currentState!.fields['BusinessName']!.value.toString(),
      'businessaddress':
          _Key.currentState!.fields['BusinessAddress']!.value.toString(),
      'tinnumber': _Key.currentState!.fields['tinnumber']!.value.toString(),
      'bcatagory': selectedValue,
      'workingday': _Key.currentState!.fields['workingday']!.value.toString(),
      'openinghours': _Key.currentState!.fields['OpenTime']!.value.toString(),
      'closinghours': _Key.currentState!.fields['CloseTime']!.value.toString(),
      'services': _Key.currentState!.fields['services']!.value.toString(),
      'description':
          _Key.currentState!.fields['BusinessDescription']!.value.toString(),
      'city': selectedValue1,
      'location':
          _Key.currentState!.fields['BusinessAddress']!.value.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Business Accounts Requests")
                .doc(_auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              return ListView(scrollDirection: Axis.vertical, children: [
                Stack(children: [
                  /* _image != null
              ? Center(
                  child: CircleAvatar(backgroundImage: MemoryImage(_image!)),
                )
              : Center(
                  child: CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.grey,
                  ),
                ),
          Positioned(
              child: IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              pickImage(ImageSource.gallery);
            },
          ))
        ]),*/
                  FormBuilder(
                      key: _Key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Business Name*',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: FormBuilderTextField(
                                  name: 'BusinessName',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["Business Name"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Business Address*',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: FormBuilderTextField(
                                  name: 'BusinessAddress',
                                  decoration: InputDecoration(
                                      hintText: snapshot
                                          .data!["Business Address"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Business Description*',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: FormBuilderTextField(
                                  name: 'BusinessDescription',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["description"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Business Catagory',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: DropdownButton(
                                value: selectedValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: catagory
                                    .map((String catagory) => DropdownMenuItem(
                                          value: catagory,
                                          child: Text(catagory),
                                        ))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                              )),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'City',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: DropdownButton(
                                value: selectedValue1,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: city
                                    .map((String city) => DropdownMenuItem(
                                          value: city,
                                          child: Text(city),
                                        ))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue1 = newValue!;
                                  });
                                },
                              )),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Services',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: FormBuilderTextField(
                                  name: 'services',
                                  decoration: InputDecoration(
                                      hintText:
                                          snapshot.data!["service"].toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                'Tin number',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: FormBuilderTextField(
                                  name: 'tinnumber',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["Tin number"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Opening Hours*',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 200, 0),
                            child: FormBuilderDateTimePicker(
                              name: 'OpenTime',
                              inputType: InputType.time,
                              decoration: InputDecoration(
                                  hintText:
                                      snapshot.data!["openinghours"].toString(),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Closing Hours*',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 200, 0),
                            child: FormBuilderDateTimePicker(
                              name: 'CloseTime',
                              inputType: InputType.time,
                              decoration: InputDecoration(
                                  hintText:
                                      snapshot.data!["closinghours"].toString(),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Contact Details*',
                                style: TextStyle(fontSize: 16),
                              )),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'First Name',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              child: FormBuilderTextField(
                                  name: 'FirstName',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["First Name"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Last Name',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              child: FormBuilderTextField(
                                  name: 'LastName',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["Last Name"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'working days',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              child: FormBuilderTextField(
                                  name: 'workingday',
                                  decoration: InputDecoration(
                                      hintText: snapshot
                                          .data!["Business Address"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              child: FormBuilderTextField(
                                  keyboardType: TextInputType.phone,
                                  name: 'PhoneNo',
                                  decoration: InputDecoration(
                                      hintText: snapshot.data!["Phone Number"]
                                          .toString(),
                                      border: OutlineInputBorder()))),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                              child: Text(
                                'Email Address',
                                style: TextStyle(fontSize: 16),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                              child: FormBuilderTextField(
                                  name: 'Email',
                                  decoration: InputDecoration(
                                      hintText:
                                          snapshot.data!["Email"].toString(),
                                      border: OutlineInputBorder()))),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 100)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.teal),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30)))),
                                    onPressed: () async {
                                      await editprofile();
                                    },
                                    child: const Text('Update')),
                              )),
                        ],
                      ))
                ]),
              ]);
            }));
  }
}
