import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/views/auth/auth_option_screen.dart';
import 'package:ev_point/views/onboard/onboard_screen.dart';
import 'package:ev_point/views/onboard/splash_screen.dart';
import 'package:ev_point/views/profile/onboard_profile_screen.dart';
import 'package:ev_point/views/profile/selfieCamera_screen.dart';
import 'package:flutter/material.dart';

import '../views/auth/otp_screen.dart';
import '../views/auth/signup_screen.dart';

class AppPages {

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splashRoute : (context) =>const SplashScreen(),
    AppRoutes.onboardRoute : (context) => const OnboardScreen(),
    AppRoutes.signupRoute : (context) => const SignupScreen(),
    AppRoutes.otpRoute: (context) =>  OtpScreen(),
    AppRoutes.onboardProfileRoute : (context) => OnboardProfile(),
    AppRoutes.selfieRoute : (context) => SelfiecameraScreen(),
    AppRoutes.authOptionRoute  : (context) => AuthOptionScreen()
  };
}