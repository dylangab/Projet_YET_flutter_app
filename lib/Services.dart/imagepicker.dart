// Importing necessary Flutter packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

// Asynchronous function to pick an image from the specified source
pickImage(ImageSource source) async {
  // Creating an instance of ImagePicker
  final ImagePicker _imagePicker = ImagePicker();

  // Picking an image from the specified source
  XFile? _file = await _imagePicker.pickImage(source: source);

  // Checking if an image was successfully picked
  if (_file != null) {
    // Reading the image as bytes and returning the result
    return await _file.readAsBytes();
  }
}

class ClassName {
  void sendReportindi() {
    FirebaseFirestore.instance
        .collection("Reports on Individual Account")
        .add({'bid': "", 'uid': "", 'report': ""});
  }

  void sendReportbuz() {
    FirebaseFirestore.instance
        .collection("Reports on buz Account")
        .add({'bid': "", 'uid': "", 'report': ""});
  }

  void sendwarningindi(String? uid) {
    FirebaseFirestore.instance
        .collection("Indivdual Accounts")
        .doc(uid)
        .collection('messages')
        .doc(uid)
        .set({
      'senderName': "YEt App",
      'status': "unseen",
      'profilePic': "admin",
      'title': "Your Account Has Been Reported",
      'message':
          "Your account has been reported for ....., please be advised before we terminate your account",
      'timestamp': "${DateTime.now()}",
    });
  }

  void sendwarningbuz(String? bid) {
    FirebaseFirestore.instance
        .collection('Business Accounts Requests')
        .doc(bid)
        .collection('messages')
        .doc(bid)
        .set({
      'senderName': "YEt App",
      'status': "unseen",
      'profilePic': "admin",
      'title': "Your Account Has Been Reported",
      'message':
          "Your account has been reported for ....., please be advised before we terminate your account",
      'timestamp': "${DateTime.now()}",
    });
  }
}
