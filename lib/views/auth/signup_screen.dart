import 'package:ev_point/controllers/signup_provider.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_input/phone_input_package.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/app_color.dart';
import '../../widgets/back_arrow.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final signUpProvider = context.watch<SignupProvider>();
    
    // final phoneController = PhoneController(PhoneNumber.parse("0"));
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
        // leadingWidth: 35,
        
        // leading: Icon(Icons.arrow_back_ios),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w), 
          child: SingleChildScrollView(
            child: SizedBox(
              height: ScreenUtil().screenHeight,
              child: Column(
                spacing: 30.h,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0.h,),
                  // SvgPicture.asset("asset/icon/left_arrow.svg", ),
                  Text(Constants.helloThere, style: TextStyles.h3Bold32,),
                  Text(Constants.pleaseEnterNumber, style: TextStyles.bodyXlargeRegular18,),
              
                  PhoneInput(
                    focusNode: focusNode,
                    countrySelectorNavigator: CountrySelectorNavigator.dialog(),
                    controller: null,
                    initialValue: null,
                    shouldFormat: true,
                    defaultCountry: IsoCode.US,
                    style: TextStyles.h5Bold20,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyles.bodyLargeBold16,
                      
                      border: UnderlineInputBorder(
              
                      ),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primary_900))
                      
                      
                    ),
                    validator: PhoneValidator.validMobile(),
                    isCountrySelectionEnabled: true,
                    showFlagInInput: true,
                    flagShape: BoxShape.rectangle,
                    flagSize: 16,
                    enabled: true,
                      
                    onSubmitted: (value) {
                     
                    },
                    onChanged: (value) {
                       debugPrint("onChanged() called");
                      signUpProvider.setMobileNumber = value!.nsn.trim();
                      debugPrint("mobileNumber: ${signUpProvider.mobileNumber}");
                    },
                    
                    
                    
                  ),
              
                  Row(
                    children: [
                      Checkbox(
                        value: signUpProvider.userAggreed,
                        activeColor: AppColor.primary_900,
              
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), ),
                        onChanged: (_){
                          signUpProvider.doAgree();
                      }),
                      Expanded(
                        child: RichText(
                          maxLines: 3,
                          
                          text: TextSpan(
                            style: TextStyle(color: AppColor.greyScale900, fontSize: 16.sp, fontWeight: FontWeight.w600 ),
                            children: [
                              TextSpan(
                                text: "I agree to EVPoint",
                                
                              ),
                              TextSpan(
                                text: " Public Agreement, Terms, Privacy Policy,", style: TextStyle ( fontWeight: FontWeight.w600, fontSize: 16.sp, fontFamily: Constants.urbanistFont, color: AppColor.primary_900, ),
                                onEnter: (event) {
                                  debugPrint("clicked $event");
                                },
                              ),
                              TextSpan(
                                text: " and confirm that I am over 17 years old.", 
                              )
                            ]
                          ),
                          
                        ),
                      ),
              
                      
                    ],
                  ),
              
                  Spacer(),
              
                  SafeArea(
                    child: Column(
                      spacing: 30.h,
                      children: [
                        Divider(thickness: 0.5.w,),
                        CustomButton(
                          onTapCallback: () {
                             debugPrint("user agree: ${signUpProvider.userAggreed} and mobile number: ${signUpProvider.mobileNumber}");
                            if( signUpProvider.mobileNumber.isNotEmpty && signUpProvider.userAggreed ){
                              
                              Navigator.pushNamed(context, AppRoutes.otpRoute, arguments: <String, dynamic>{
                                "code" : "+91",
                                "phone_number" : signUpProvider.mobileNumber
                              });
              
                              
                            }
                            
                          },
                          margin: EdgeInsets.only(bottom: 10.h),
                              title: Constants.continu,
                             buttonColor: signUpProvider.userAggreed ? AppColor.primary_900 : AppColor.buttonDisabled,
                             textColor: AppColor.white,
                             borderRadius: 30.r,
                             boldText: true, 
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

}