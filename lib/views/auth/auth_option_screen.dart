import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/auth/signup_screen.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class AuthOptionScreen extends StatefulWidget {
  const AuthOptionScreen({super.key});

  @override
  State<AuthOptionScreen> createState() => _AuthOptionScreenState();
}

class _AuthOptionScreenState extends State<AuthOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          spacing: 20,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100,),
            Image.asset("${Constants.imagePath}Frame.png", height: 250),
            
            Column(
              spacing: 15,
              children: [
                Text(Constants.letsYouIn, style: TextStyles.h2Bold40),
                authOption(
                  () {},
                  "google_icon.png",
                  Constants.continueWithGoogle,
                ),
                authOption(
                  () {},
                  "facebook_icon.png",
                  Constants.continueWithFacebook,
                ),
                authOption(
                  () {},
                  "apple_icon.png",
                  Constants.continueWithApple,
                ),
              ],
            ),

            Row(
              children: [
                Expanded(child: Divider(indent: 15,endIndent: 15, color: AppColor.greyScale200,)),
                Text(Constants.or, style: TextStyle(fontFamily: Constants.urbanistFont, fontSize: 18, fontWeight: FontWeight.w600, color: AppColor.greyScale700)),
                Expanded(child: Divider(indent: 15,endIndent: 15, color: AppColor.greyScale200)),  
              ],
            ),

            CustomButton(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              title: Constants.signInWithPhoneNumber,
              buttonColor: AppColor.primary_900,
              textColor: AppColor.white,
              boldText: true,
              borderRadius: 30,
              isShadow: true,
              onTapCallback: () {
                
              },
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignupScreen() ),  (Route<dynamic> route) => false );
                },
                child: RichText(
                  text: TextSpan(
                    text: Constants.dontHaveAccount,
                    style: TextStyle(color: AppColor.black, fontFamily: Constants.urbanistFont, fontWeight: FontWeight.w500, fontSize: 16),
                    children: [
                      TextSpan(text: "  ${Constants.signUp}", style: TextStyle(color: AppColor.primary_900, fontWeight: FontWeight.w800, fontSize: 16))
                    ]
                  ),
                  
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget authOption(
    void Function() onTap,
    String authIconName,
    String authName,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyScale200),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("${Constants.iconPath}${authIconName}", height: 20),
            Text(authName, style: TextStyles.bodyLargeSemiBold16),
          ],
        ),
      ),
    );
  }
}
