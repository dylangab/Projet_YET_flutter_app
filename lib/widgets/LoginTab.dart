import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/BusinessAccount/accountCheckPage.dart';
import 'package:final_project/Pages/IndividualAccount/homepage.dart';
import 'package:final_project/models/getX.dart';
import 'package:final_project/models/individualacc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:final_project/Pages/BusinessAccount/BpPage.dart';
import 'package:final_project/Pages/IndividualAccount/IndiAccount.dart';
import 'package:final_project/Pages/BusinessAccount/BpRegisterPage.dart';
import 'package:final_project/mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> with TickerProviderStateMixin {
  bool _passwordHide = false;
  bool _emailerror = false;
  final PropertyController propertyController = Get.find();
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _buzemailfocusNode = FocusNode();
  final FocusNode _buzpassfocusNode = FocusNode();
  TextEditingController indiemail = TextEditingController();
  TextEditingController indipass = TextEditingController();
  TextEditingController buzemail = TextEditingController();
  TextEditingController buzpass = TextEditingController();
  int? index = 0;
  bool indiclicked = true;
  bool? buzclicked;
  bool? _exists;
  final individualAccountFetch controller = Get.put(individualAccountFetch());

  @override
  void dispose() {
    indiemail.dispose();
    indipass.dispose();
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Stack(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 229, 143, 101)),
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icon.png'),
                          fit: BoxFit.fill)),
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
          "Login",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        )),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 21, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonClick(index!)
                        ? const Color.fromARGB(255, 229, 143, 101)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1.5,
                            color: Color.fromARGB(255, 229, 143, 101)),
                        borderRadius: BorderRadius.circular(15))),
                child: const Text(
                  "Individual Account",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonClick(index!)
                      ? Colors.white
                      : const Color.fromARGB(255, 229, 143, 101),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 229, 143, 101)),
                      borderRadius: BorderRadius.circular(15))),
              child: const Text("Business Account",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      Expanded(
        child: IndexedStack(
          index: index,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: ListView(
                  children: [
                    SizedBox(
                      child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                                child: Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 30, 10),
                                child: TextFormField(
                                  focusNode: _focusNode,
                                  validator: (value) {
                                    String? message;
                                    if (value!.isEmpty) {
                                      message = "email should not be empty";
                                    } else if (!value.contains('@')) {
                                      message = "email incorrect";
                                    }
                                    return message;
                                  },
                                  cursorColor:
                                      const Color.fromARGB(255, 66, 106, 90),
                                  controller: indiemail,
                                  decoration: InputDecoration(
                                      errorBorder: _emailerror
                                          ? const OutlineInputBorder()
                                          : const OutlineInputBorder(),
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
                                            color: Color.fromARGB(
                                                255, 66, 106, 90)),
                                      )),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                                child: Text('Password'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 30, 10),
                                child: TextFormField(
                                  focusNode: _focusNode1,
                                  obscureText: !_passwordHide,
                                  cursorColor:
                                      const Color.fromARGB(255, 66, 106, 90),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: indipass,
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
                                              color: Color.fromRGBO(
                                                  66, 106, 90, 1))),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 66, 106, 90))),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 66, 106, 90)),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 21),
                                child: Center(
                                  child: ElevatedButton(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.fromLTRB(
                                                100, 15, 100, 15)),
                                        elevation: MaterialStatePropertyAll(5),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 229, 143, 101)),
                                      ),
                                      onPressed: () async {
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: indiemail.value.text
                                                      .trim(),
                                                  password: indipass.value.text
                                                      .trim())
                                              .then(
                                                (value) => isDocumentExists(
                                                    "Individual Accounts",
                                                    value.user!.uid),
                                              );
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "No user found for that email."),
                                            ));

                                            print(
                                                'No user found for that email.');
                                          } else if (e.code ==
                                              'wrong-password') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Wrong password provided for that user."),
                                            ));

                                            print(
                                                'Wrong password provided for that user.');
                                          }
                                        }
                                      },
                                      child: const Text('Login')),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(3, 10, 0, 3),
                                    child: Text(
                                      'Dont have an account',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          3, 10, 20, 3),
                                      child: GestureDetector(
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const IndiAccount()));
                                        },
                                      )),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: ListView(children: [
                SizedBox(
                  child: Form(
                      key: _formkey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                            child: Text(
                              'Email',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _buzemailfocusNode,
                              validator: (value) {
                                String? message;
                                if (value!.isEmpty) {
                                  message = "email should not be empty";
                                } else if (!value.contains('@')) {
                                  message = "email incorrect";
                                }
                                return message;
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              controller: buzemail,
                              decoration: InputDecoration(
                                  errorBorder: _emailerror
                                      ? const OutlineInputBorder()
                                      : const OutlineInputBorder(),
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
                            child: Text('Password'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                            child: TextFormField(
                              focusNode: _buzpassfocusNode,
                              obscureText: !_passwordHide,
                              cursorColor:
                                  const Color.fromARGB(255, 66, 106, 90),
                              keyboardType: TextInputType.emailAddress,
                              controller: buzpass,
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
                                    if (_formkey2.currentState!.validate()) {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: buzemail.value.text,
                                                password: buzpass.value.text)
                                            .then((value) => Get.to(
                                                () => AccountCheckPage(),
                                                arguments: value));
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "No user found for that email."),
                                          ));

                                          print(
                                              'No user found for that email.');
                                        } else if (e.code == 'wrong-password') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Wrong password provided for that user."),
                                          ));

                                          print(
                                              'Wrong password provided for that user.');
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("error"),
                                      ));
                                    }
                                  },
                                  child: const Text('Login')),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(3, 10, 0, 3),
                                child: Text(
                                  'Dont have an account',
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3, 10, 20, 3),
                                child: GestureDetector(
                                  child: const Text(
                                    'Register',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () async {
                                    await Get.to(() => const BpRegister());
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                )
              ]),
            )
          ],
        ),
      )
    ])));
  }

  bool buttonClick(int index) {
    if (index == 0) {
      indiclicked = true;
    } else if (index == 1) {
      indiclicked = false;
    }
    return indiclicked;
  }

  Future<void> isDocumentExists(String collection, String documentId) async {
    // Get a reference to the document
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(collection).doc(documentId);

    // Get the document
    DocumentSnapshot docSnapshot = await docRef.get();

    // Check if the document exists
    _exists = docSnapshot.exists;
    if (_exists == true) {
      controller.firebaseService.call();
      Get.to(() => const mainPage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User doesn't exist."),
      ));
    }
  }
}
