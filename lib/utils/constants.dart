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
  
  static const String title1 = "Easily find EV charging stations around you";
  static const String subTitle1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
  static const String title2 = "Fast and simple to make reservation & check in";
  static const String title3 = "Make payments safely & quickly with EVPoint";


  // static final anonKey = String.fromEnvironment("ANON_API_KEY");
  static var anonKey = dotenv.env["ANON_API_KEY"];
  static const supabaseUrl = "https://wpsmdogwuajwcmrtbqol.supabase.co";


}