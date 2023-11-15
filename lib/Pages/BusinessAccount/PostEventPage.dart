import 'package:flutter/material.dart';
import 'package:final_project/models/requestpost.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});

  @override
  _PostEventState createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final _formKey2 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.teal,
        ),
        drawer: const Drawer(),
        backgroundColor: Colors.teal,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                    child: Text(
                  'Post Event',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FormBuilder(
                        key: _formKey2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: FormBuilderTextField(
                                  name: 'Eventname',
                                  decoration: InputDecoration(
                                      hintText: 'Event Name',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.grey[800]),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: FormBuilderTextField(
                                  name: 'Description',
                                  decoration: InputDecoration(
                                      hintText:
                                          'write about your event detials',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.grey[800]),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: FormBuilderDateRangePicker(
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030),
                                  name: 'EventDate',
                                  decoration: InputDecoration(
                                      hintText: 'Event Date',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.grey[800]),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: FormBuilderTextField(
                                  name: 'EventLocation',
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.map_sharp)),
                                      hintText: 'Event Location',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal: 70)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.teal),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                      onPressed: () async {
                                        final FirebaseFirestore _firestore =
                                            FirebaseFirestore.instance;
                                        await _firestore
                                            .collection('Event')
                                            .doc()
                                            .set({
                                          'event_description': _formKey2
                                              .currentState!
                                              .fields['Description']!
                                              .value
                                              .toString(),
                                          'event_name': _formKey2.currentState!
                                              .fields['Eventname']!.value
                                              .toString(),
                                          'event_date': _formKey2.currentState!
                                              .fields['EventDate']!.value
                                              .toString(),
                                          'event_location': _formKey2
                                              .currentState!
                                              .fields['EventLocation']!
                                              .value
                                              .toString(),
                                        });
                                      },
                                      child: const Text('Post')),
                                )),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
