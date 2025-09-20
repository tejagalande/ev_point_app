import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants{

  static const String urbanistFont = "Urbanist";

  // Assets icon path
  static const String iconPath = "asset/icon/";

  //  Assets image path
  static const String imagePath = "asset/image/";

  static const String letsYouIn = "Let\'s you in";
  static const String continueWithGoogle = "Continue with Google";
  static const String continueWithFacebook = "Continue with Facebook";
  static const String continueWithApple = "Continue with Apple";
  static const String or = "Or";
  static const String signInWithPhoneNumber = "Sign in with Phone Number";
  static const String dontHaveAccount = "Don\'t have an account?";
  static const String signUp = "Sign up";
  static const String skip = "Skip";
  static const String next = "Next";
  static const String continu = "Continue";
  static const String helloThere = "Hello there 👋";
  static const String pleaseEnterNumber = "Please enter your phone number. You will receive an OTP code in the next step for the verification process.";
  static const String otpCodeVerify = "OTP code verification 🔐";
  static const String didNotReceiveOtp = "Didn\'t receive otp code?";
  static const String youCanResendCode = "You can resend code in ";
  static const String reSend = "Resend";

  static const String title1 = "Easily find EV charging stations around you";
  static const String subTitle1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
  static const String title2 = "Fast and simple to make reservation & check in";
  static const String title3 = "Make payments safely & quickly with EVPoint";


  static final anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indwc21kb2d3dWFqd2NtcnRicW9sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE1MjI3NDEsImV4cCI6MjA2NzA5ODc0MX0.zdTcyy5_7JkI7TLsLLIgr_9ZMlF0QIv99VhQBklmDWI";
  // static var anonKey = dotenv.env["ANON_API_KEY"];
  static const supabaseUrl = "https://wpsmdogwuajwcmrtbqol.supabase.co";


  // color gradients
  static LinearGradient mapSearchLinearGradient = LinearGradient(
                  colors: [
                    AppColor.primary_900.withAlpha(170),
                    AppColor.primary_900.withAlpha(130),
                    AppColor.primary_900.withAlpha(100),
                    AppColor.primary_900.withAlpha(90),
                    AppColor.primary_900.withAlpha(20),
                  ],
                  stops: [
                    1.0, 0.8, 0.3, 0.2, 0.1
                  ].reversed.toList(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                );


}