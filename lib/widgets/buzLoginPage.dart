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

class buzLoginPage extends StatefulWidget {
  const buzLoginPage({super.key});

  @override
  _buzLoginPageState createState() => _buzLoginPageState();
}

class _buzLoginPageState extends State<buzLoginPage>
    with TickerProviderStateMixin {
  bool _passwordHide = false;
  bool _emailerror = false;
  final PropertyController propertyController = Get.find();
  final _formkey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  String? _message;

  TextEditingController buzemail = TextEditingController();
  TextEditingController buzpass = TextEditingController();

  @override
  void dispose() {
    buzemail.dispose();
    buzpass.dispose();
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 229, 143, 101)),
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
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
              child: Text(
            "Welcome To Yet",
            style: TextStyle(fontSize: 40),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
              child: Text(
            "Login to your Business Account",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          )),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 21),
            child: SizedBox(
                height: 430,
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _formkey,
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
                            focusNode: _focusNode,
                            validator: (value) {
                              String? message;
                              if (value!.isEmpty) {
                                message = "email should not be empty";
                              }
                              return message;
                            },
                            cursorColor: Color.fromARGB(255, 66, 106, 90),
                            controller: buzemail,
                            decoration: InputDecoration(
                                errorBorder: _emailerror
                                    ? OutlineInputBorder()
                                    : OutlineInputBorder(),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                          child: Text('Password'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                          child: TextFormField(
                            focusNode: _focusNode1,
                            obscureText: !_passwordHide,
                            cursorColor: Color.fromARGB(255, 66, 106, 90),
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
                                  color: Color.fromARGB(255, 229, 143, 101),
                                  icon: Icon(_passwordHide
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
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
                                    try {
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: buzemail.value.text.trim(),
                                              password:
                                                  buzpass.value.text.trim())
                                          .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyHomePage())));
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "No user found for that email."),
                                        ));

                                        print('No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Wrong password provided for that user."),
                                        ));

                                        print(
                                            'Wrong password provided for that user.');
                                      }
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("error"),
                                    ));
                                  }
                                },
                                child: Text('Login')),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 0, 3),
                              child: Text(
                                'Dont have an account',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 20, 3),
                              child: GestureDetector(
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 40, right: 5),
                                child: Text(
                                  'Want to login to your Individual account',
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 40, right: 50),
                                child: GestureDetector(
                                  child: Text(
                                    'Click here',
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
                              ),
                            )
                          ],
                        )
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
    ));

    /*   return Scaffold(
      
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          children: [
            const Center(
              child: Text(
                'Yet',
                style: TextStyle(fontSize: 35),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Login To Our App',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TabBar(
                  padding: const EdgeInsets.all(10),
                  controller: tabController1,
                  tabs: const [
                    Tab(
                      text: 'Individual Account',
                    ),
                    Tab(
                      text: 'Business Account',
                    )
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(controller: tabController1, children: [
                Form(
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
                        keyboardType: TextInputType.emailAddress,
                        controller: indiemail,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
                      child: Text('Password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 30, 10),
                      child: TextFormField(
                        controller: indipass,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: indiemail.value.text.trim(),
                                      password: indipass.value.text.trim())
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage())));
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
                        Text('Dont have an account'),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: Text('Register'),
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
                    )
                  ],
                )),
                Form(
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
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
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
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
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
                                          builder: (context) =>
                                              const BpPage())));
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
                                      builder: (context) =>
                                          const BpRegister()));
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )),
              ]),
            )
          ],
        ));*/
  }
}
