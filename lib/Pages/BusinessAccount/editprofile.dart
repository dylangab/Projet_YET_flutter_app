import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/getX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:switcher_button/switcher_button.dart';

import 'chooseLocation.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

String _text = loremIpsum(words: 60, initWithLorem: true);
String? bussinessName;
String? description;
String? service;
String? profilePic;
String? firstName;
String? lastName;
String? phoneNo;
String? address;
LatLng? coordinates;
TextEditingController buzName = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController serviceController = TextEditingController();
TextEditingController phoneNoController = TextEditingController();
bool editbuzName = false;
bool editdecription = false;
bool editService = false;
bool editBusinesshours = false;
bool editOwnerInfo = false;
bool editAddInfo = false;

Color _mondaytext = Colors.black;
Color _tuesdaytext = Colors.black;
Color _wendaytext = Colors.black;
Color _thurstext = Colors.black;
Color _fridaytext = Colors.black;
Color _saturndaytext = Colors.black;
Color _sundaytext = Colors.black;
final _formBuilderOpenTimeKey = GlobalKey<FormBuilderState>();
final _formBuilderCloseTimeKey = GlobalKey<FormBuilderState>();
String? coordinateText;
final GetMapController controller = Get.put(GetMapController());

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 238, 240, 235),
            child: Stack(fit: StackFit.loose, children: [
              Positioned(
                  child: Container(
                decoration: BoxDecoration(
                    /*  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(''))  */
                    color: Colors.red),
                height: 130,
              )),
              Positioned(
                  top: 100,
                  left: 30,
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Center(
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_a_photo_sharp)),
                        ),
                        radius: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: editbuzName
                            ? SizedBox(
                                width: 200,
                                child: TextFormField(
                                  initialValue: "Business Name",
                                  controller: buzName,
                                  decoration: InputDecoration(),
                                ))
                            : SizedBox(
                                child: Stack(fit: StackFit.loose, children: [
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text("Business Name",
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 5,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              editbuzName = !editbuzName;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 18,
                                          )))
                                ]),
                              ),
                      )
                    ],
                  )),
            ]),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: SizedBox(
              child: Stack(children: [
                Container(
                  color: Colors.red,
                  width: 200,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 255,
                    child: IconButton(
                        onPressed: () {
                          print("ok");
                          setState(() {
                            editdecription = !editdecription;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        )))
              ]),
            ),
          ),
          editdecription
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 200,
                          child: TextFormField(
                              initialValue: _text,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration())),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(
                    _text,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: SizedBox(
              child: Stack(children: [
                Container(
                  color: Colors.red,
                  width: 200,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Service",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 285,
                    child: IconButton(
                        onPressed: () {
                          print("ok");
                          setState(() {
                            editService = !editService;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        )))
              ]),
            ),
          ),
          editService
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 200,
                          child: TextFormField(
                              initialValue: _text,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration())),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(
                    _text,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: SizedBox(
              child: Stack(children: [
                Container(
                  color: Colors.red,
                  width: 200,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Business Hours",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 220,
                    child: IconButton(
                        onPressed: () {
                          print("ok");
                          setState(() {
                            editBusinesshours = !editBusinesshours;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        )))
              ]),
            ),
          ),
          editBusinesshours
              ? SizedBox(
                  child: Column(children: [
                    Padding(
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
                                            ? _tuesdaytext =
                                                const Color.fromARGB(
                                                    255, 229, 143, 101)
                                            : _tuesdaytext = Colors.black;
                                      });
                                    },
                                    size: 40,
                                    offColor: Colors.black26,
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: SwitcherButton(
                                    onChange: (value) {
                                      setState(() {
                                        value
                                            ? _wendaytext =
                                                const Color.fromARGB(
                                                    255, 229, 143, 101)
                                            : _wendaytext = Colors.black;
                                      });
                                    },
                                    size: 40,
                                    offColor: Colors.black26,
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
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
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SwitcherButton(
                                    onChange: (value) {
                                      setState(() {
                                        value
                                            ? _fridaytext =
                                                const Color.fromARGB(
                                                    255, 229, 143, 101)
                                            : _fridaytext = Colors.black;
                                      });
                                    },
                                    size: 40,
                                    offColor: Colors.black26,
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
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
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: SwitcherButton(
                                    onChange: (value) {
                                      setState(() {
                                        value
                                            ? _sundaytext =
                                                const Color.fromARGB(
                                                    255, 229, 143, 101)
                                            : _sundaytext = Colors.black;
                                      });
                                    },
                                    size: 40,
                                    offColor: Colors.black26,
                                    onColor: const Color.fromARGB(
                                        255, 229, 143, 101),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                    )
                  ]),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Table(
                    children: const [
                      TableRow(children: [
                        Text(
                          'Days',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text("Opening Hours",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text("Closing Hours",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Monday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Tuesday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Wednesday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Thursday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Friday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Saturnday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Sunday',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text("1:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: SizedBox(
              child: Stack(children: [
                Container(
                  color: Colors.red,
                  width: 200,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Owner Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 200,
                    child: IconButton(
                        onPressed: () {
                          print("ok");
                          setState(() {
                            editOwnerInfo = !editOwnerInfo;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        )))
              ]),
            ),
          ),
          editOwnerInfo
              ? SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: buzName,
                        decoration: InputDecoration(hintText: "First Name"),
                      ),
                      TextFormField(
                        controller: buzName,
                        decoration: InputDecoration(hintText: "Last Name"),
                      ),
                      TextFormField(
                        controller: buzName,
                        decoration: InputDecoration(hintText: "PhoneNo"),
                      ),
                    ],
                  ))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Full Name:- Eren Yeager",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                "Phone No:- 0932323222",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: SizedBox(
              child: Stack(children: [
                Container(
                  color: Colors.red,
                  width: 200,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 180,
                    child: IconButton(
                        onPressed: () {
                          print("ok");
                          setState(() {
                            editAddInfo = !editAddInfo;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        )))
              ]),
            ),
          ),
          editAddInfo
              ? Padding(
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
                  ))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Address:- Addis Abeba",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
          Visibility(
              visible: _buttonVisability(),
              maintainState: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                child: Center(
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 229, 143, 101),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text("Save Changes"),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> getAccount(String bid) async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection("Business Accounts Requests")
        .doc(bid);
    late Stream<DocumentSnapshot> stream;
    late DocumentSnapshot documentSnapshot;

    reference.get().then((value) => documentSnapshot = value);

    stream = reference.snapshots();
    stream.listen((event) {
      documentSnapshot = event;
      bussinessName = documentSnapshot.get('Business Name');
      description = documentSnapshot.get('description');
      service = documentSnapshot.get('service');
      profilePic = documentSnapshot.get('profile_Pic');
      firstName = documentSnapshot.get('First Name');
      lastName = documentSnapshot.get('Last Name');
      address = documentSnapshot.get('Address');
      phoneNo = documentSnapshot.get('Phone Number');
      print(bussinessName);
      print(description);
      print(service);
    });
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

  bool _buttonVisability() {
    bool? value = false;
    if (editAddInfo == true ||
        editBusinesshours == true ||
        editOwnerInfo == true ||
        editService == true ||
        editbuzName == true ||
        editdecription == true) {
      value = true;
    }
    Future<void> updateEdit(String bid) async {
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
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Wednesday_Closetime']!.value
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
      if (editAddInfo == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .update({'address': coordinateText});
      }
      if (editOwnerInfo == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .update({
          'First Name': firstNameController.value.text,
          'Last Name': lastNameController.value.text,
          'Phone Number': phoneNoController.value.text
        });
      }
      if (editService == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .update({
          'service': serviceController.value.text,
        });
      }
      if (editdecription == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .update({
          'description': descriptionController.value.text,
        });
      }
      if (editbuzName == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .update({
          'Business Name': buzName.value.text,
        });
      }
    }

    return value;
  }
}
