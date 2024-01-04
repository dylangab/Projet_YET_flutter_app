import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Services.dart/getX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
final FirebaseAuth _auth = FirebaseAuth.instance;
bool enableMonday = false;
bool enableTuesday = false;
bool enablewenday = false;
bool enableThrusday = false;
bool enableFriday = false;
bool enableSatrunday = false;
bool enableSunday = false;
final Map<String, dynamic> businessHours = {};
List<Map<String, dynamic>> businessHoursList = [];

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void dispose() {
    buzName.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    descriptionController.dispose();
    serviceController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Business Accounts Requests")
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            return ListView(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 238, 240, 235),
                  child: Stack(fit: StackFit.loose, children: [
                    Positioned(
                        top: 50,
                        left: 30,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: Center(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_a_photo_sharp)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: editbuzName
                                  ? SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: TextFormField(
                                        controller: buzName,
                                        decoration: const InputDecoration(),
                                      ))
                                  : SizedBox(
                                      child:
                                          Stack(fit: StackFit.loose, children: [
                                        SizedBox(
                                          height: 80,
                                          width: 200,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Text(
                                                snapshot.data!["Business Name"],
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                                icon: const Icon(
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
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: SizedBox(
                    child: Stack(children: [
                      Container(
                        width: 200,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
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
                              icon: const Icon(
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
                                    decoration: const InputDecoration())),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Text(
                          snapshot.data!["description"],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: SizedBox(
                    child: Stack(children: [
                      Container(
                        width: 200,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Service",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
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
                              icon: const Icon(
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
                                    decoration: const InputDecoration())),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Text(
                          snapshot.data!["service"],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: SizedBox(
                    child: Stack(children: [
                      Container(
                        width: 200,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Business Hours",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 225,
                          child: IconButton(
                              onPressed: () {
                                print("ok");
                                setState(() {
                                  editBusinesshours = !editBusinesshours;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                              )))
                    ]),
                  ),
                ),
                editBusinesshours
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 80, top: 10),
                                  child: Text("Days",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    "Opens",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10, right: 30),
                                  child: Text("Closes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SwitcherButton(
                                        onChange: (value) {
                                          setState(() {
                                            value
                                                ? _mondaytext =
                                                    const Color.fromARGB(
                                                        255, 229, 143, 101)
                                                : _mondaytext = Colors.black;
                                            enableMonday = !enableMonday;
                                          });
                                        },
                                        size: 40,
                                        offColor: Colors.black26,
                                        onColor: const Color.fromARGB(
                                            255, 229, 143, 101),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _tuesdaytext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _tuesdaytext = Colors.black;
                                              enableTuesday = !enableTuesday;
                                            });
                                          },
                                          size: 40,
                                          offColor: Colors.black26,
                                          onColor: const Color.fromARGB(
                                              255, 229, 143, 101),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _wendaytext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _wendaytext = Colors.black;
                                              enablewenday = !enablewenday;
                                            });
                                          },
                                          size: 40,
                                          offColor: Colors.black26,
                                          onColor: const Color.fromARGB(
                                              255, 229, 143, 101),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _thurstext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _thurstext = Colors.black;
                                              enableThrusday = !enableThrusday;
                                            });
                                          },
                                          size: 40,
                                          offColor: Colors.black26,
                                          onColor: const Color.fromARGB(
                                              255, 229, 143, 101),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _fridaytext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _fridaytext = Colors.black;
                                              enableFriday = !enableFriday;
                                            });
                                          },
                                          size: 40,
                                          offColor: Colors.black26,
                                          onColor: const Color.fromARGB(
                                              255, 229, 143, 101),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _saturndaytext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _saturndaytext =
                                                      Colors.black;
                                              enableSatrunday =
                                                  !enableSatrunday;
                                            });
                                          },
                                          size: 40,
                                          offColor: Colors.black26,
                                          onColor: const Color.fromARGB(
                                              255, 229, 143, 101),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: SwitcherButton(
                                          onChange: (value) {
                                            setState(() {
                                              value
                                                  ? _sundaytext =
                                                      const Color.fromARGB(
                                                          255, 229, 143, 101)
                                                  : _sundaytext = Colors.black;
                                              enableSunday = !enableSunday;
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                fontSize: 16,
                                                color: _tuesdaytext)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Text("Wednesday",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _wendaytext)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 5),
                                        child: Text("Thursday",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _thurstext)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 5),
                                        child: Text("Friday",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _fridaytext)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 5),
                                        child: Text("Saturday",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _saturndaytext)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 5),
                                        child: Text("Sunday",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: _sundaytext)),
                                      ),
                                    ],
                                  ),
                                ),

                                /// this is where opening time will be displayed

                                FormBuilder(
                                  key: _formBuilderOpenTimeKey,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 10, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: SizedBox(
                                            width: 50,
                                            height: 30,
                                            child: FormBuilderDateTimePicker(
                                              enabled: enableMonday,
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
                                              enabled: enableTuesday,
                                              timePickerInitialEntryMode:
                                                  TimePickerEntryMode.inputOnly,
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
                                              enabled: enablewenday,
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
                                              enabled: enableThrusday,
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
                                              enabled: enableFriday,
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
                                              enabled: enableSatrunday,
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
                                              enabled: enableSunday,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(60, 10, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: SizedBox(
                                            width: 50,
                                            height: 30,
                                            child: FormBuilderDateTimePicker(
                                              enabled: enableMonday,
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
                                              enabled: enableTuesday,
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
                                              enabled: enablewenday,
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
                                              enabled: enableThrusday,
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
                                              enabled: enableFriday,
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
                                              enabled: enableSatrunday,
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
                                              enabled: enableSunday,
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
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Day')),
                            DataColumn(label: Text('Opens')),
                            DataColumn(label: Text('Closes')),
                          ],
                          rows: businessHoursList.map((dayData) {
                            return DataRow(
                              cells: [
                                DataCell(Text(dayData['Day'])),
                                DataCell(Text(dayData['Data']['Opens'])),
                                DataCell(Text(dayData['Data']['Closes'])),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: SizedBox(
                    child: Stack(children: [
                      Container(
                        width: 200,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Owner Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
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
                              icon: const Icon(
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
                              decoration:
                                  const InputDecoration(hintText: "First Name"),
                            ),
                            TextFormField(
                              controller: buzName,
                              decoration:
                                  const InputDecoration(hintText: "Last Name"),
                            ),
                            TextFormField(
                              controller: buzName,
                              decoration:
                                  const InputDecoration(hintText: "PhoneNo"),
                            ),
                          ],
                        ))
                    : Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Full Name:- ${snapshot.data!["First Name"]} ${snapshot.data!["Last Name"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "Phone No:-  ${snapshot.data!["Phone Number"]}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: SizedBox(
                    child: Stack(children: [
                      Container(
                        width: 200,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Additional Information",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
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
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                              )))
                    ]),
                  ),
                ),
                editAddInfo
                    ? Obx(
                        () => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1.5,
                                      color: const Color.fromARGB(
                                          255, 66, 106, 90))),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(controller.place.value),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(
                                              () => const ChooseLocationPage());
                                        },
                                        icon: const Icon(
                                          Icons.map_sharp,
                                          color: Colors.black,
                                          size: 20,
                                        )),
                                  ]),
                            )),
                      )
                    : Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Address:- ${snapshot.data!["Business Address"]}",
                          style: TextStyle(
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
            );
          }),
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

  Future<Map<String, dynamic>> createBusinessHoursMap() async {
    if (enableMonday == true) {
      businessHours.addEntries({
        'Monday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Monday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Monday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enableTuesday == true) {
      businessHours.addEntries({
        'Tuesday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['tuesday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['tuesday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enablewenday == true) {
      businessHours.addEntries({
        'Wednesday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Wednesday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Wednesday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enableThrusday == true) {
      businessHours.addEntries({
        'Thursday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Thursday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Thursday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enableFriday == true) {
      businessHours.addEntries({
        'Friday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Friday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Friday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enableSatrunday == true) {
      businessHours.addEntries({
        'Saturnday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Saturday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Saturday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    if (enableSunday == true) {
      businessHours.addEntries({
        'Sunday': {
          'Opens': _formBuilderOpenTimeKey
              .currentState!.fields['Sunday_Opentime']?.value
              .toString(),
          'Closes': _formBuilderCloseTimeKey
              .currentState!.fields['Sunday_Closetime']?.value
              .toString(),
        }
      }.entries);
    }
    return businessHours;
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
            .update({'Business Address': controller.place.value});
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
      if (editBusinesshours == true) {
        FirebaseFirestore.instance
            .collection("Business Accounts Requests")
            .doc(bid)
            .collection('bussiness_Hours')
            .doc(bid)
            .set(businessHours);
      }
    }

    return value;
  }

  Future<void> fetchData() async {
    try {
      String userId =
          "0yDSrgeDwPPWS9zQFfHWnPYkoTr2"; // Assuming `_auth` is your authentication instance.
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Business Accounts Requests')
          .doc(userId)
          .collection('bussiness_Hours')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> businessHoursMap = snapshot.data()!;
        businessHoursList = businessHoursMap.entries.map((entry) {
          return {'Day': entry.key, 'Data': entry.value};
        }).toList();
        setState(() {}); // Trigger a rebuild after fetching the data
      } else {
        // Handle the case where the document doesn't exist.
      }
    } catch (e) {
      // Handle any errors that occurred during the fetch.
      print("Error fetching business hours: $e");
    }
  }
}
