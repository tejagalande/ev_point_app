import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_input/phone_input_package.dart';

class PersonalInfoProvider extends ChangeNotifier {
  bool isEditing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController(); // Removed in favor of PhoneController
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final SingleValueDropDownController genderController =
      SingleValueDropDownController();

  final FocusNode dobFocusNode = FocusNode();

  // Image Picker
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  // Phone Number
  PhoneController? phoneInputController;
  IsoCode? currentIsoCode;
  String phoneNumber = "";

  PersonalInfoProvider() {
    loadUserData();
  }

  void loadUserData() {
    // Mock data
    nameController.text = "Andrew Ainsley";
    emailController.text = "andrew.ainsley@yourdomain.com";

    // Initialize PhoneController
    try {
      final parsedNumber = PhoneNumber.parse("+1 111 467 378 399");
      phoneInputController = PhoneController(parsedNumber);
      currentIsoCode = parsedNumber.isoCode;
      phoneNumber = parsedNumber.international;
    } catch (e) {
      debugPrint("Error parsing phone number: $e");
      phoneInputController = PhoneController(
        PhoneNumber(isoCode: IsoCode.US, nsn: ""),
      );
      currentIsoCode = IsoCode.US;
    }

    dobController.text = "12/27/1995";
    addressController.text = "3517 W. Gray Street, New York";
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void handlePhoneChange(PhoneNumber? value) {
    if (value == null) return;

    if (currentIsoCode != null && value.isoCode != currentIsoCode) {
      // Country changed, clear the number
      // We create a new PhoneNumber with the new ISO code and empty NSN
      final newNumber = PhoneNumber(isoCode: value.isoCode, nsn: "");
      phoneInputController?.value = newNumber;
      phoneNumber = "";
      currentIsoCode = value.isoCode;
    } else {
      // Just a number update
      phoneNumber = value.international;
      // currentIsoCode might be same, but update just in case
      currentIsoCode = value.isoCode;
    }
    notifyListeners();
  }

  void toggleEditing() {
    if (isEditing) {
      // Save logic
      if (formKey.currentState!.validate()) {
        // Save data
        isEditing = false;
        notifyListeners();
      }
    } else {
      isEditing = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    // phoneController.dispose();
    phoneInputController?.dispose();
    dobController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }
}
