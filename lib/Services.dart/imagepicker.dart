// Importing necessary Flutter packages

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
