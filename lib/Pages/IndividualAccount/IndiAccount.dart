import 'package:final_project/Pages/BusinessAccount/BpRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/individualacc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class IndiAccount extends StatefulWidget {
  const IndiAccount({super.key});

  @override
  _IndiAccountState createState() => _IndiAccountState();
}

class _IndiAccountState extends State<IndiAccount> {
  @override
  void initState() {
    super.initState();
    gettoken();
  }

  final _formkey = GlobalKey<FormState>();

  final _passwordvisible = false;
  String? mydevicetoken;
  String? gender;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  final FocusNode _phoneNoNode = FocusNode();
  bool _passwordHide = false;
  /*void requestpermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('provisional grant');
    } else {
      print('not granted');
    }
  }
*/
  void gettoken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mydevicetoken = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
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
              "Create your Individual Account",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21),
            child: SizedBox(
              height: 920,
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
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
                            controller: firstName,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
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
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
                            controller: lastName,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
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
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
                            controller: email,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
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
                          child: TextFormField(
                            focusNode: _phoneNoNode,
                            validator: (value) {
                              String? message;
                              if (value!.isEmpty) {
                                message = "Phone number should not be empty";
                              }
                              return message;
                            },
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
                            controller: phoneNo,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
                                )),
                          ),
                        ),
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
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
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
                                  color:
                                      const Color.fromARGB(255, 229, 143, 101),
                                  icon: Icon(_passwordHide
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
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
                            cursorColor: const Color.fromARGB(255, 66, 106, 90),
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
                                  color:
                                      const Color.fromARGB(255, 229, 143, 101),
                                  icon: Icon(_passwordHide
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 66, 106, 90))),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 66, 106, 90)),
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
                                    await individualacc().regiseruser(
                                        firstname: firstName.value.text.trim(),
                                        lastname: lastName.value.text.trim(),
                                        email: email.value.text.trim(),
                                        password: password.value.text.trim(),
                                        phoneno: phoneNo.value.text.trim(),
                                        userInterest: []);
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
                                'What to create an business account',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 15, 20, 3),
                              child: GestureDetector(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BpRegister()));
                                },
                              ),
                            )
                          ],
                        ),
                      ])),
            ),
          ),
        ]),
      ),
    );
  }
}
