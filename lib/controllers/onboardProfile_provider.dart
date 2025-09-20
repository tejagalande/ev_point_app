import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/shared_pref.dart';
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
  String? phoneNumber;
  String? dateOfBirth;
  String? address;
  bool? status;
  FocusNode dobFocusNode = FocusNode();
  bool isLoading = false;

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

    isLoading = true;
    log("is loading: $isLoading");
    notifyListeners();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      log(
        "name- $firstName mobile- $phoneNumber email- $email gender- $gender dob- ${dOBTextEditingController.text} address- $address image path- $imagePath",
      );
      log("form data has been saved.");
      // final user = SupabaseManager().client.
      var fullName = firstName!.split(' ');
      var userId = SharedPref().getValue("user_id");

      if (userId != null && userId.isNotEmpty) {


        log("user id: $userId");
        
      }
      Future.delayed(Duration(seconds: 2), (){
        isLoading = false;
        status = true;
        log("is loading: $isLoading");
        notifyListeners();

        
      });
      // await SupabaseManager.supabaseClient.storage.from("ev-point-storage").

      // final response = await SupabaseManager().client.storage.from("ev-point-storage")
      //   .upload("user_profile/$userId/$_imageName", File(imagePath!))
      //   .then((value) async{
      //     final publicUrl = SupabaseManager()
      //                       .client.storage.from("ev-point-storage")
      //                       .getPublicUrl("user_profile/$userId/$_imageName");       

      //     log("public url- $publicUrl");

      //     await SupabaseManager.supabaseClient.from('User').insert({
      //       "first_name" : fullName[0],
      //       "last_name" : fullName[1],
      //       "email_id" : email,
      //       "country_code" : "+91",
      //       "phone_number" : phoneNumber,
      //       "gender" : gender,
      //       "dob" : dOBTextEditingController.text,
      //       "address" : addressTextEditingController.text,
      //       "country" : "India",
      //       "profile_url" : publicUrl,
      //       "user_auth_id" : userId
      //     }).count().then((value) {

      //     log("User data inserted. -> $value");

          
      //   },);   
      //   },)

      //   .catchError((error) {
      //     log("Error: $error");
      //   },);



      
    }
  }
}
