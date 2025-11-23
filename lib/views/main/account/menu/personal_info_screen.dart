import 'dart:io';

import 'package:date_format_field/date_format_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:ev_point/controllers/account/personal_info_provider.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/profile/widget/dateOfBirthWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/back_arrow.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonalInfoProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(context),
        body: Consumer<PersonalInfoProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileImage(context, provider),
                  SizedBox(height: 24.h),
                  Form(
                    key: provider.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Full Name"),
                        _buildTextField(
                          controller: provider.nameController,
                          hintText: "Full Name",
                          readOnly: !provider.isEditing,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? "Please enter full name"
                                      : null,
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Phone Number"),
                        PhoneInput(
                          countrySelectorNavigator:
                              const CountrySelectorNavigator.dialog(),
                          controller: provider.phoneInputController,
                          shouldFormat: true,
                          defaultCountry: IsoCode.US,
                          style: TextStyles.h5Bold20.copyWith(
                            color: AppColor.greyScale900,
                          ),
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyles.h5Bold20.copyWith(
                              color: AppColor.greyScale500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                          ),
                          validator: PhoneValidator.validMobile(),
                          isCountrySelectionEnabled: provider.isEditing,
                          showFlagInInput: true,
                          flagShape: BoxShape.rectangle,
                          flagSize: 16,
                          enabled: provider.isEditing,
                          onChanged: (value) {
                            provider.handlePhoneChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Email"),
                        _buildTextField(
                          controller: provider.emailController,
                          hintText: "Email",
                          readOnly: !provider.isEditing,
                          keyboardType: TextInputType.emailAddress,
                          validator:
                              (value) =>
                                  value!.isEmpty ? "Please enter email" : null,
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Gender"),
                        DropDownTextField(
                          clearOption: false,
                          controller: provider.genderController,
                          isEnabled: provider.isEditing,
                          textStyle: TextStyles.h5Bold20.copyWith(
                            color: AppColor.greyScale900,
                          ),
                          textFieldDecoration: InputDecoration(
                            hintText: "Gender",
                            hintStyle: TextStyles.h5Bold20.copyWith(
                              color: AppColor.greyScale500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_900,
                              ),
                            ),
                          ),
                          dropDownIconProperty: IconProperty(
                            icon: IconData(0xf82b, fontFamily: 'MaterialIcons'),
                            color: AppColor.primary_900,
                          ),
                          dropDownList: const [
                            DropDownValueModel(name: "Male", value: "Male"),
                            DropDownValueModel(name: "Female", value: "Female"),
                            DropDownValueModel(name: "Other", value: "Other"),
                          ],
                          dropDownItemCount: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please choose your gender";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Date of Birth"),
                        Dateofbirthwrapper(
                          controller: provider.dobController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please select your date of birth";
                            }
                            return null;
                          },
                          style: TextStyles.h5Bold20.copyWith(
                            color: AppColor.greyScale900,
                          ),
                          builder: (controller, errorText, style) {
                            return DateFormatField(
                              focusNode: provider.dobFocusNode,
                              controller: controller,
                              firstDate: DateTime(1900, 1, 1),
                              lastDate: DateTime.now().subtract(
                                const Duration(days: 365 * 18),
                              ),
                              decoration: InputDecoration(
                                errorText:
                                    errorText != null && errorText.isNotEmpty
                                        ? errorText
                                        : null,
                                suffixIconColor: AppColor.primary_900,
                                iconColor: AppColor.primary_900,
                                hintText: "Date of Birth",
                                hintStyle: TextStyles.h5Bold20.copyWith(
                                  color: AppColor.greyScale500,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.primary_900,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.primary_900,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.primary_900,
                                  ),
                                ),
                              ),
                              type: DateFormatType.type2,
                              onComplete: (date) {},
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Street Address"),
                        _buildTextField(
                          controller: provider.addressController,
                          hintText: "Street Address",
                          readOnly: !provider.isEditing,
                          keyboardType: TextInputType.streetAddress,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? "Please enter address"
                                      : null,
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: backArrow(),
      ),
      title: Text(
        "Personal Info",
        style: TextStyles.h4Bold24.copyWith(color: AppColor.greyScale900),
      ),
      actions: [
        Consumer<PersonalInfoProvider>(
          builder: (context, provider, child) {
            return IconButton(
              onPressed: () => provider.toggleEditing(),
              icon:
                  provider.isEditing
                      ? Icon(Icons.check, color: AppColor.primary_900)
                      : SvgPicture.asset(
                        "asset/icon/edit_icon.svg",
                        colorFilter: ColorFilter.mode(
                          AppColor.primary_900,
                          BlendMode.srcIn,
                        ),
                      ),
            );
          },
        ),
        SizedBox(width: 16.w),
      ],
    );
  }

  Widget _buildProfileImage(
    BuildContext context,
    PersonalInfoProvider provider,
  ) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 120.r,
            width: 120.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.r),
              child:
                  provider.imageFile != null
                      ? Image.file(provider.imageFile!, fit: BoxFit.cover)
                      : Image.asset(
                        "${Constants.imagePath}empty_profile_image.png",
                        fit: BoxFit.fill,
                      ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (provider.isEditing) {
                  _showImagePickerOptions(context, provider);
                }
              },
              child: Icon(Icons.edit_square, color: AppColor.primary_900),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePickerOptions(
    BuildContext context,
    PersonalInfoProvider provider,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  provider.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  provider.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyles.h6Bold18.copyWith(color: AppColor.greyScale900),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: TextStyles.h5Bold20.copyWith(color: AppColor.greyScale900),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.h5Bold20.copyWith(color: AppColor.greyScale500),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary_900),
        ),
      ),
    );
  }
}
