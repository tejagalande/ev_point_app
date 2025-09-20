import 'dart:io';

import 'package:date_format_field/date_format_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:ev_point/controllers/onboardProfile_provider.dart';
import 'package:ev_point/routes/app_pages.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/profile/selfieCamera_screen.dart';
import 'package:ev_point/views/profile/widget/dateOfBirthWrapper.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widgets/back_arrow.dart';

class OnboardProfile extends StatefulWidget {
  const OnboardProfile({super.key});

  @override
  State<OnboardProfile> createState() => _OnboardProfileState();
}

class _OnboardProfileState extends State<OnboardProfile> {
  

  bool isRender = false;

  @override
  void initState() {
  


    
    super.initState();
    // context.watch<OnboardprofileProvider>().dobFocusNode.addListener((){
    //   if(context.watch<OnboardprofileProvider>().dobFocusNode.hasFocus) {
    //     print("textfield has focused");
    //   }
    //   else{
    //     print("textfield has lost focus");
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isRender) {

      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.isNotEmpty) {

      context.read<OnboardprofileProvider>().phoneNumber = args['phone_number'];
      
    }
        
      }      
    },);

  }
  
  Map<String, dynamic> args = {};




  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<OnboardprofileProvider>();
    profileProvider.dobFocusNode.addListener(() {
      if (profileProvider.dobFocusNode.hasFocus) {
        debugPrint("dob textfield has focused");
      } else {
        debugPrint("textfield is lost focus");
      }
    },);



    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: backArrow()),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: SingleChildScrollView(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                SizedBox(height: 40.0.h,),
                Text("Complete your profile 📋", style: TextStyles.h3Bold32,),
                SizedBox(height: 10.0.h,),
                Text("Don\'t worry, only you can see your personal data. No one else will be able to see it.", style: TextStyles.bodyXlargeRegular18,),
                
                

                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.0.h),
                  child: Center(
                    child: Stack(
                      // alignment: Alignment.center,
                      children: [
               

                        profileProvider.getImageName.isNotEmpty ? 
                                                Container( 
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade100
                                                  ),
                                                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(120.r),
                        child: Image.file(File(profileProvider.getImagePath ), fit: BoxFit.fill)),
                                                )
                                                :
                                                 Container(
                                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                                  child:  Image.asset("${Constants.imagePath}empty_profile_image.png", height: 120,)
                                                  ),
                       
                       Positioned(
                        bottom: 10,
                        right: 0,
                        child: GestureDetector(
                          onTap:() async{
                            if (await profileProvider.requestCameraPermission()) {
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => SelfiecameraScreen(),
                              // ));
                               Navigator.pushNamed(context, AppRoutes.selfieRoute).then((onValue){
                                if (onValue != null) {
                                  final newData = onValue as Map<String, String>;
                                  debugPrint("map data: $newData");
                                  profileProvider.setImageName = newData['image_name'] ?? "";
                                  profileProvider.setImagePath = newData['image_path'] ?? "";
                                  // debugPrint("extract image path: ${profileProvider.getImagePath}");
                                  // debugPrint("extract image name: ${profileProvider.getImageName}");
                                  
                                }
                               }).catchError((onError){
                                debugPrint("Error occurred: $onError");
                               });
                              //  profileProvider.setImageName = result.toString();
                             
                            }
                          } ,
                          child: Icon(Icons.edit_square, color: AppColor.primary_900,)),
                       )
                      ],
                      
                    ),
                  ),
                ),
            
                Form(
                  key: profileProvider.formKey,
                  onChanged: () {
                    profileProvider.checkAllFields();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Full name
                      Text("Full Name", style: TextStyles.bodyLargeBold16,),
                      TextFormField(
                        controller: profileProvider.nameTextEditingController,
                        style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale900, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          hintStyle: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale500, fontWeight: FontWeight.w800 ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          )
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter the full name.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty && profileProvider.formKey.currentState!.validate()) {
                            profileProvider.isAllFieldsFilled = true;
                          } 
                        },
                        onSaved: (newValue) {
                          profileProvider.firstName = newValue!;
                        },
                      ),

                      SizedBox(height: 10.0.h,),
            
            
                      // Email
                      Text("Email", style: TextStyles.bodyLargeBold16,),
                      TextFormField(
                        controller: profileProvider.emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale900, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale500, fontWeight: FontWeight.w800 ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          )
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the email address.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty && profileProvider.formKey.currentState!.validate() ) {
                            profileProvider.isAllFieldsFilled = true;
                          } 
                        },
                        onSaved: (newValue) {
                          profileProvider.email = newValue!;
                        },
                      ),
            
                      SizedBox(height: 10.0.h,),
                      // gender
                      Text("Gender", style: TextStyles.bodyLargeBold16,),
                      DropDownTextField(
                        clearOption: false,
                        controller: profileProvider.genderController,
                        textStyle:TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale900, fontWeight: FontWeight.w800),
                        textFieldDecoration: InputDecoration(
                          hintText: "Gender",
                          hintStyle:  TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale500, fontWeight: FontWeight.w800 ),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primary_900)),
                          focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: AppColor.primary_900) )
                        ),
                        dropDownIconProperty: IconProperty( icon: IconData(0xf82b, fontFamily: 'MaterialIcons', ), color: AppColor.primary_900 ),
                        clearIconProperty: IconProperty( icon: IconData(0xf82b, fontFamily: 'MaterialIcons', ), color: AppColor.primary_900 ),
                        dropDownList: [
                          DropDownValueModel(name: "Male", value: "Male"),
                          DropDownValueModel(name: "Female", value: "Female"),
                          DropDownValueModel(name: "Other", value: "Other"),
                        ],
                        dropDownItemCount: 3,
                        
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please choose your gender.";
                          }
                          profileProvider.gender = value;
                          return null;
                        },
                        
                        
                        onChanged: (value ) {
                          // debugPrint("in onChanged()- $value");
                          // profileProvider.gender = value.toString();
                          
                          if(value != null && profileProvider.formKey.currentState!.validate() ){
                            profileProvider.isAllFieldsFilled = true;
                          }
                        },
            
                      ),
            
                      SizedBox(height: 10.0.h,),
                      // date of birth 
                      Text("Date of Birth", style: TextStyles.bodyLargeBold16,),
                      Dateofbirthwrapper(
                        controller: profileProvider.dOBTextEditingController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please select your date of birth";
                          }
                          return null;
                        },
                        style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale900, fontWeight: FontWeight.w800),
                        builder: (controller, errorText, style) {
                         return DateFormatField(
                        focusNode: profileProvider.dobFocusNode,
                        controller: controller,
                        firstDate: DateTime(1930,1,1),
                        lastDate: DateTime.timestamp(),
                        decoration: InputDecoration(
                          
                          errorText: errorText != null && errorText.isNotEmpty ? errorText : "",
                          suffixIconColor: AppColor.primary_900,
                          iconColor: AppColor.primary_900,
                          hintText: "Date of Birth",
                          hintStyle: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale500, fontWeight: FontWeight.w800 ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          )
                        ),
                        onComplete: (dateOfBirth) {
                          debugPrint("onComplete() called");
                          debugPrint("date of birth from controller: ${profileProvider.dOBTextEditingController.text}");
                          
                        },
                        type: DateFormatType.type2,
                        
                      ); 
                        },
                      ),
                      
                      // SizedBox(height: 10.0.h,),
                      // street address
                      Text("Street Address", style: TextStyles.bodyLargeBold16,),
                      TextFormField(
                        controller: profileProvider.addressTextEditingController,
                        keyboardType: TextInputType.streetAddress,
                        style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale900, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          hintText: "Street Address",
                          hintStyle: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 20, color: AppColor.greyScale500, fontWeight: FontWeight.w800 ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary_900)
                          )
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your address.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          profileProvider.address = newValue!;
                          debugPrint("onSaved() called.");
                        },
                        onFieldSubmitted: (value) {
                          debugPrint("onFieldSubmitted() called");
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty && profileProvider.formKey.currentState!.validate() ) {
                            profileProvider.isAllFieldsFilled = true;
                          }
                        },
                        onTapOutside: (_) {
                          if (profileProvider.address != null && profileProvider.address!.isNotEmpty) {
                            profileProvider.isAllFieldsFilled = true;
                          }
                        },
                      ),
            
                      SizedBox(height: 50.0.h,),
            
                      // Consumer<OnboardprofileProvider>(
                      //   builder: (context, value, child) {
                      //     return CustomButton(
                      //   title: Constants.continu,
                      //   buttonColor: profileProvider.isAllFieldsFilled ? 
                      //    AppColor.primary_900 : AppColor.buttonDisabled,
                      //   borderRadius: 30.0.r,
                      //   textColor: AppColor.white,
                        
                      //   onTapCallback: () {
                      //     profileProvider.submitForm();
                      //   },
                      // );
                      //   },
                      // ),

                      // Consumer2<OnboardprofileProvider, bool>(
                        
                      //   builder: (context, onboardProfileProvider, isFilled, child) {
                          
                      //   },
                      // ),

                       Consumer<OnboardprofileProvider>(
                        builder: (context, value, child) {

                              if (value.status != null && value.status!) {
                                  
                                  WidgetsBinding.instance.addPostFrameCallback((_){
                                    Navigator.popAndPushNamed(context, AppRoutes.personalizeVehicleRoute);
                                  });
                                }
                                
                         return SafeArea(
                         child: value.isLoading ? 
                         Center(
                          child: CircularProgressIndicator(),
                         )
                         : CustomButton(
                          title: Constants.continu,
                          buttonColor: profileProvider.isAllFieldsFilled ? 
                           AppColor.primary_900 : AppColor.buttonDisabled,
                          borderRadius: 30.0.r,
                          textColor: AppColor.white,
                          
                          onTapCallback: () {
                            value.submitForm();

                          },
                                               ),
                       );
                        },
                       )

                      // CustomButton(
                      //     title: Constants.continu,
                      //     buttonColor: profileProvider.isAllFieldsFilled ? 
                      //      AppColor.primary_900 : AppColor.buttonDisabled,
                      //     borderRadius: 30.0.r,
                      //     textColor: AppColor.white,
                          
                      //     onTapCallback: () {
                      //       profileProvider.submitForm();
                      //     },
                      //                          ),
                        

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}