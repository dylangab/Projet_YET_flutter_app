import 'dart:io';
import 'dart:typed_data';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:final_project/Pages/BusinessAccount/accountCheckPage.dart';
import 'package:final_project/Pages/BusinessAccount/waitingPage.dart';
import 'package:final_project/widgets/LoginTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:final_project/models/imagepicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/models/storagemethod.dart';
import 'package:final_project/models/businessaa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:latlong2/latlong.dart';

import '../IndividualAccount/IndiAccount.dart';

class BpRegister extends StatefulWidget {
  const BpRegister({super.key});

  @override
  _BpRegisterState createState() => _BpRegisterState();
}

class _BpRegisterState extends State<BpRegister> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController buzName = TextEditingController();
  TextEditingController tinNUmber = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final FocusNode _buzNode = FocusNode();
  final FocusNode _tinNode = FocusNode();
  final FocusNode _serviceNode = FocusNode();
  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  final FocusNode _phoneNoNode = FocusNode();
  bool _passwordHide = false;
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  String? imageurl;
/*
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      setState(() async {
        _image = Uint8List.fromList(await pickedImage.readAsBytes());
      });
    }

    return null; // Return null if no image was selected
  }
 

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
 */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(scrollDirection: Axis.vertical, children: [
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
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              "Welcome To Yet",
              style: TextStyle(fontSize: 40),
            )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              "Create your Business Account",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            )),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 21),
              child: SizedBox(
                  height: 1400,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Business Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _buzNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Business name should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: buzName,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Tin Number',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _tinNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Tin Number should not be empty";
                                }
                                return message;
                              },
                              cursorColor: Color.fromARGB(255, 66, 106, 94),
                              controller: tinNUmber,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Service',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _serviceNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Service should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: service,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                            child: Text(
                              "Business Owner Information",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _firstNameNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "First name should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: firstName,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Last Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _lastNameNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Last name should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: lastName,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _emailNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Email should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: email,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (value) {
                                number.phoneNumber;
                              },
                              inputBorder: const OutlineInputBorder(),
                              textFieldController: phoneNo,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              initialValue: number,
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                            ),
                          )
                          /*   Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _phoneNoNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "Phone number should not be empty";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: phoneNo,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          )*/
                          ,
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _passwordNode,
                              obscureText: !_passwordHide,
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              keyboardType: TextInputType.emailAddress,
                              controller: password,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "password Should not be empty";
                                } else if (value.length.isLowerThan(8)) {
                                  message =
                                      "Password length should br atleast greater than 8";
                                }

                                return message;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordHide = !_passwordHide;
                                      });
                                    },
                                    color: const Color.fromARGB(
                                        255, 229, 143, 101),
                                    icon: Icon(_passwordHide
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text('Confirm Password',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _confirmPasswordNode,
                              obscureText: !_passwordHide,
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              keyboardType: TextInputType.emailAddress,
                              controller: confirmPassword,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "password Should not be empty";
                                } else if (value.length.isLowerThan(8)) {
                                  message =
                                      "Password length should br atleast greater than 8";
                                } else if (value != password.text) {
                                  message = "Password doesn't match";
                                }

                                return message;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordHide = !_passwordHide;
                                      });
                                    },
                                    color: const Color.fromARGB(
                                        255, 229, 143, 101),
                                    icon: Icon(_passwordHide
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Color.fromARGB(
                                              255, 66, 106, 90))),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 66, 106, 90)),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 21),
                            child: Center(
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.fromLTRB(100, 15, 100, 15)),
                                    elevation: MaterialStatePropertyAll(5),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 229, 143, 101)),
                                  ),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      Businessacc().requestaccount(
                                          firstname:
                                              firstName.value.text.trim(),
                                          lastname: lastName.value.text.trim(),
                                          email: email.value.text.trim(),
                                          password: password.value.text.trim(),
                                          phoneno: phoneNo.value.text.trim(),
                                          businessname:
                                              buzName.value.text.trim(),
                                          businessaddress: "pending",
                                          description: "pending",
                                          bcatagory: "pending",
                                          coordinates: LatLng(3.5656, 4.000),
                                          image: [],
                                          services: service.value.text.trim(),
                                          profilePic: "",
                                          coverPhoto: "",
                                          profilefinish: "unfinished",
                                          website: "N/A",
                                          approvalStatus: "waiting",
                                          rating: 0,
                                          ratingList: [],
                                          followerIdList: [],
                                          rateUids: []);
                                      await Get.to(() => const WaitingPage());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("error"),
                                      ));
                                    }
                                  },
                                  child: const Text('Register')),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(3, 15, 0, 3),
                                child: Text(
                                  'What to create an individual account',
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 15, 20, 3),
                                child: GestureDetector(
                                  child: const Text(
                                    'Register',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const IndiAccount()));
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      )))),
          /* Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
              child: Text(
                'Email',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
              child: TextFormField(
                controller: buzemail,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
              child: Text('Password'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
              child: TextFormField(
                controller: buzpass,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: buzemail.value.text.trim(),
                              password: buzpass.value.text.trim())
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BpPage())));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: Text('Login')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Dont have an accunt'),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Text('Register'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BpRegister()));
                    },
                  ),
                )
              ],
            )
          ],
        )),*/
        ]),

        /*
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              print('${file?.path}');
              String filename = DateTime.now().microsecondsSinceEpoch.toString();
    
              Reference reference = FirebaseStorage.instance.ref();
              Reference referenceimage = reference.child('images');
              Reference referenceupload = referenceimage.child(filename);
              try {
                await referenceupload.putFile(File(file!.path));
                imageurl = await referenceupload.getDownloadURL();
              } catch (e) {}
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          /*  Stack(children: [
            
            Center(
              child: CircleAvatar(
                radius: 46,
                backgroundColor: Colors.grey,
              ),
            ),
            Positioned(
                child: IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');
                String filename =
                    DateTime.now().microsecondsSinceEpoch.toString();
    
                Reference reference = FirebaseStorage.instance.ref();
                Reference referenceimage = reference.child('images');
                Reference referenceupload = referenceimage.child(filename);
                try {
                  await referenceupload.putFile(File(file!.path));
                  imageurl = await referenceupload.getDownloadURL();
                } catch (e) {}
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
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
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()))),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 16),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                      child: FormBuilderTextField(
                          name: 'password',
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()))),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 100)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.teal),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                            onPressed: () async {
                              await Businessacc().requestaccount(
                                  firstname: _Key
                                      .currentState!.fields['FirstName']!.value
                                      .toString(),
                                  lastname: _Key.currentState!.fields['LastName']!.value
                                      .toString(),
                                  email: _Key.currentState!.fields['Email']!.value
                                      .toString(),
                                  password: _Key
                                      .currentState!.fields['password']!.value
                                      .toString(),
                                  phoneno: _Key.currentState!.fields['PhoneNo']!.value
                                      .toString(),
                                  businessname: _Key
                                      .currentState!.fields['BusinessName']!.value
                                      .toString(),
                                  businessaddress: _Key.currentState!
                                      .fields['BusinessAddress']!.value
                                      .toString(),
                                  bcatagory: selectedValue,
                                  openinghours:
                                      _Key.currentState!.fields['OpenTime']!.value.toString(),
                                  closinghours: _Key.currentState!.fields['CloseTime']!.value.toString(),
                                  services: _Key.currentState!.fields['services']!.value.toString(),
                                  description: _Key.currentState!.fields['BusinessDescription']!.value.toString(),
                                  city: selectedValue1,
                                  location: _Key.currentState!.fields['BusinessAddress']!.value.toString(),
                                  image: imageurl!,
                                  approvalStatus: "pending");
                              /*
                                  .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginTab())));*/
                            },
                            child: const Text('Register')),
                      )),
                ],
              ))
        ]),*/
      ),
    );
  }
}
