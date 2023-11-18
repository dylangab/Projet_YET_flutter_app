import 'dart:io';

import 'package:final_project/Pages/BusinessAccount/chooseLocation.dart';
import 'package:final_project/models/businessaa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:final_project/models/imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/getX.dart';

class FinishProPage extends StatefulWidget {
  const FinishProPage({super.key});

  @override
  State<FinishProPage> createState() => _FinishProPageState();
}

class _FinishProPageState extends State<FinishProPage> {
  final _auth = FirebaseAuth.instance;
  String? selectedValue;
  bool? ischecked = false;
  Color _mondaytext = Colors.black;
  Color _tuesdaytext = Colors.black;
  Color _wendaytext = Colors.black;
  Color _thurstext = Colors.black;
  Color _fridaytext = Colors.black;
  Color _saturndaytext = Colors.black;
  Color _sundaytext = Colors.black;
  List<String> catagoryList = [];
  final _formkey = GlobalKey<FormState>();
  final _formBuilderOpenTimeKey = GlobalKey<FormBuilderState>();
  final _formBuilderCloseTimeKey = GlobalKey<FormBuilderState>();

  TextEditingController buzDescription = TextEditingController();
  final GetMapController controller = Get.put(GetMapController());
  final FocusNode _buzDescription = FocusNode();
  TextEditingController _website = TextEditingController();
  final FocusNode _websiteNode = FocusNode();
  TextEditingController buzLocation = TextEditingController();
  final FocusNode _buzLocation = FocusNode();
  String? profilePicUrl;
  String? covorPhotoUrl;
  String? coordinateText;

  @override
  void initState() {
    super.initState();
    fetchCatagory();
    coordinateToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 229, 143, 101)),
                height: 150,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Material(
                    elevation: 5,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Center(
                child: Text(
              "Finish Your Business Profile",
              style: TextStyle(fontSize: 32),
            )),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 15),
                child: Text(
                  'Profile Picture',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                child: Text(
                  '(you can put your logo or brand in here)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Material(
              shape: const CircleBorder(),
              elevation: 3,
              child: Container(
                width: 50,
                height: 120,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 240, 235),
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');
                        String filename =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        Reference reference = FirebaseStorage.instance.ref();
                        Reference referenceimage = reference.child('images');
                        Reference referenceupload =
                            referenceimage.child(filename);
                        try {
                          await referenceupload.putFile(File(file!.path));
                          profilePicUrl =
                              await referenceupload.getDownloadURL();
                        } catch (e) {}
                      },
                      icon: const Icon(Icons.add_a_photo)),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 21, left: 15),
            child: Text(
              'Cover Photo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Material(
              shape: const CircleBorder(),
              elevation: 3,
              child: Container(
                width: 20,
                height: 120,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 240, 235),
                    shape: BoxShape.circle),
                child: Center(
                  child: IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');
                        String filename =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        Reference reference = FirebaseStorage.instance.ref();
                        Reference referenceimage = reference.child('images');
                        Reference referenceupload =
                            referenceimage.child(filename);
                        try {
                          await referenceupload.putFile(File(file!.path));
                          covorPhotoUrl =
                              await referenceupload.getDownloadURL();
                        } catch (e) {}
                      },
                      icon: const Icon(Icons.add_a_photo)),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 21, left: 15),
                    child: Text(
                      'Business Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1.5,
                              color: const Color.fromARGB(255, 66, 106, 90))),
                      child: TextFormField(
                          focusNode: _buzDescription,
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message =
                                  "Business decription should not be empty";
                            }
                            return message;
                          },
                          cursorColor: const Color.fromARGB(255, 66, 106, 90),
                          controller: buzDescription,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)

                              /*focusedBorder: OutlineInputBorder(
                                
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 66, 106, 90))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 66, 106, 90))),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 106, 90)),*/
                              )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 21, left: 15),
                    child: Text(
                      'Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1.5,
                                color: const Color.fromARGB(255, 66, 106, 90))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(coordinateText.toString()),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => const ChooseLocationPage());
                                    coordinateToText();
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.map_sharp,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                            ]),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 21, left: 15),
                    child: Text(
                      'Business Catagory',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 66, 106, 90),
                              width: 1.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                            isDense: true,
                            iconEnabledColor: Colors.red,
                            value: selectedValue,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            items: catagoryList
                                .map((String catagory) => DropdownMenuItem(
                                      value: catagory,
                                      child: Text(catagory),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            }),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                    child: Text(
                      "Business Hours",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 80, top: 10),
                          child: Text("Days",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            "Opens",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, right: 30),
                          child: Text("Closes",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SwitcherButton(
                                onChange: (value) {
                                  setState(() {
                                    value
                                        ? _mondaytext = const Color.fromARGB(
                                            255, 229, 143, 101)
                                        : _mondaytext = Colors.black;
                                  });
                                },
                                size: 40,
                                offColor: Colors.black26,
                                onColor:
                                    const Color.fromARGB(255, 229, 143, 101),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _tuesdaytext = const Color.fromARGB(
                                              255, 229, 143, 101)
                                          : _tuesdaytext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _wendaytext = const Color.fromARGB(
                                              255, 229, 143, 101)
                                          : _wendaytext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _thurstext = const Color.fromARGB(
                                              255, 229, 143, 101)
                                          : _thurstext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _fridaytext = const Color.fromARGB(
                                              255, 229, 143, 101)
                                          : _fridaytext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _saturndaytext =
                                              const Color.fromARGB(
                                                  255, 229, 143, 101)
                                          : _saturndaytext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: SwitcherButton(
                                  onChange: (value) {
                                    setState(() {
                                      value
                                          ? _sundaytext = const Color.fromARGB(
                                              255, 229, 143, 101)
                                          : _sundaytext = Colors.black;
                                    });
                                  },
                                  size: 40,
                                  offColor: Colors.black26,
                                  onColor:
                                      const Color.fromARGB(255, 229, 143, 101),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // this is where days are displayed
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                child: Text(
                                  "Monday",
                                  style: TextStyle(
                                      fontSize: 16, color: _mondaytext),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 5),
                                child: Text("Tuesday",
                                    style: TextStyle(
                                        fontSize: 16, color: _tuesdaytext)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Text("Wednesday",
                                    style: TextStyle(
                                        fontSize: 16, color: _wendaytext)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 5),
                                child: Text("Thursday",
                                    style: TextStyle(
                                        fontSize: 16, color: _thurstext)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 5),
                                child: Text("Friday",
                                    style: TextStyle(
                                        fontSize: 16, color: _fridaytext)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 5),
                                child: Text("Saturday",
                                    style: TextStyle(
                                        fontSize: 16, color: _saturndaytext)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 5),
                                child: Text("Sunday",
                                    style: TextStyle(
                                        fontSize: 16, color: _sundaytext)),
                              ),
                            ],
                          ),
                        ),

                        /// this is where opening time will be displayed

                        FormBuilder(
                          key: _formBuilderOpenTimeKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Monday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'tuesday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Wednesday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Thursday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Friday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Saturday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Sunday_Opentime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FormBuilder(
                          key: _formBuilderCloseTimeKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(60, 10, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Monday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'tuesday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Wednesday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Thursday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Friday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Saturday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: FormBuilderDateTimePicker(
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                      name: 'Sunday_Closetime',
                                      inputType: InputType.time,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
                    child: RichText(
                        text: const TextSpan(
                            text: "Additional Information",
                            style: TextStyle(fontSize: 18),
                            children: [
                          TextSpan(
                              text: "(optional)",
                              style: TextStyle(fontSize: 15))
                        ])),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 21, left: 15),
                    child: Text(
                      'Website',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                    child: TextFormField(
                      focusNode: _websiteNode,
                      cursorColor: const Color.fromARGB(255, 66, 106, 90),
                      controller: _website,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 66, 106, 90))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 66, 106, 90))),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 66, 106, 90)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(100, 15, 100, 15)),
                    elevation: MaterialStatePropertyAll(5),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 229, 143, 101)),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Map<String, dynamic> businessHours = {
                        'Monday': {
                          'Opens': _formBuilderOpenTimeKey
                              .currentState!.fields['Monday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['Monday_Closetime']!.value
                              .toString(),
                        },
                        'Tuesday': {
                          'Opens': _formBuilderOpenTimeKey
                              .currentState!.fields['tuesday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['tuesday_Closetime']!.value
                              .toString(),
                        },
                        'Wednesday': {
                          'Opens': _formBuilderOpenTimeKey
                              .currentState!.fields['Wednesday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey.currentState!
                              .fields['Wednesday_Closetime']!.value
                              .toString(),
                        },
                        'Thursday': {
                          'Opens': _formBuilderCloseTimeKey
                              .currentState!.fields['Thursday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['Thursday_Closetime']!.value
                              .toString(),
                        },
                        'Friday': {
                          'Opens': _formBuilderCloseTimeKey
                              .currentState!.fields['Friday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['Friday_Closetime']!.value
                              .toString(),
                        },
                        'Saturnday': {
                          'Opens': _formBuilderCloseTimeKey
                              .currentState!.fields['Saturday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['Saturday_Closetime']!.value
                              .toString(),
                        },
                        'Sunday': {
                          'Opens': _formBuilderCloseTimeKey
                              .currentState!.fields['Sunday_Opentime']!.value
                              .toString(),
                          'Closes': _formBuilderCloseTimeKey
                              .currentState!.fields['Sunday_Closetime']!.value
                              .toString(),
                        },
                      };
                      Businessacc()
                          .finishAccount(
                            businessaddress: coordinateText.toString(),
                            profilefinish: "yes",
                            description: buzDescription.value.text,
                            coverPhoto: covorPhotoUrl!,
                            bcatagory: selectedValue!,
                            profilePic: profilePicUrl!,
                            website: _website.value.text,
                            coordinates: LatLng(
                              controller.coordinates!.value.latitude,
                              controller.coordinates!.value.longitude,
                            ),
                          )
                          .then((value) => FirebaseFirestore.instance
                              .collection('Business Accounts Requests')
                              .doc(_auth.currentUser!.uid)
                              .collection('bussiness_Hours')
                              .add(businessHours));
                    }
                  },
                  child: const Text('Submit')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchCatagory() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Business_catagory')
        .doc('0p0kRqz8hx5WmR2NTnUA')
        .get();
    if (doc.exists) {
      catagoryList = (doc['catagories'] as List<dynamic>).cast<String>();
      for (var item in catagoryList) {
        print(item);
      }
    }
  }

  void coordinateToText() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      controller.coordinates!.value.latitude,
      controller.coordinates!.value.longitude,
      localeIdentifier: 'en',
    );

    Placemark placemark = placemarks.first;
    setState(() {
      coordinateText = " ${placemark.locality}, ${placemark.country}, ";
    });
  }
}
