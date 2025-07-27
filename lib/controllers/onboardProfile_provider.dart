import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardprofileProvider extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;
  String? imagePath;
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController genderTextEditingController =
      TextEditingController();
  final TextEditingController dOBTextEditingController =
      TextEditingController();
  final TextEditingController addressTextEditingController =
      TextEditingController();
  final genderController = SingleValueDropDownController();
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? _imageName;

  String? dateOfBirth;
  String? address;
  FocusNode dobFocusNode = FocusNode();

  bool isAllFieldsFilled = false;

  set setImageName(String name) {
    _imageName = name;
    notifyListeners();
  }

  set setImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  String get getImagePath {
    return imagePath ?? "";
  }

  String get getImageName {
    return _imageName ?? "";
  }

  OnboardprofileProvider() {
    // requestCameraPermission();
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      openAppSettings();
      return false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      debugPrint("User has granted the camera permission.");
      return true;
    }
  }

  checkAllFields() {
    if (_formKey.currentState!.validate() &&
        nameTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        dOBTextEditingController.text.isNotEmpty &&
        addressTextEditingController.text.isNotEmpty) {
      isAllFieldsFilled = !isAllFieldsFilled;
    } else {
      isAllFieldsFilled = false;
    }

    notifyListeners();
  }

  submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint(
        "name- $firstName email- $email gender- $gender dob- ${dOBTextEditingController.text} address- $address image path- $imagePath",
      );
      debugPrint("form data has been saved.");
      // final user = SupabaseManager().client.


      final response = await SupabaseManager().client.storage.from("ev-point-storage").upload("user_profile/$_imageName", File(imagePath!));

      final publicUrl = await SupabaseManager().client.storage.from("ev-point-storage").getPublicUrl("user_profile/$_imageName");

      debugPrint("public url- $publicUrl");
    }
  }
}
