import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/views/auth/auth_option_screen.dart';
import 'package:ev_point/views/book/book_station_screen.dart';
import 'package:ev_point/views/book/payment_method_screen.dart';
import 'package:ev_point/views/book/review_summary_screen.dart';
import 'package:ev_point/views/book/vehicle_list_screen.dart';
import 'package:ev_point/views/main/account/menu/add_new_payment_screen.dart';
import 'package:ev_point/views/main/account/menu/my_payment_methods_screen.dart';
import 'package:ev_point/views/main/booking/charging_process_screen.dart';
import 'package:ev_point/views/main/widget/main_screen.dart';
import 'package:ev_point/views/onboard/onboard_screen.dart';
import 'package:ev_point/views/onboard/splash_screen.dart';
import 'package:ev_point/views/personalize/personalize_screen.dart';
import 'package:ev_point/views/profile/onboard_profile_screen.dart';
import 'package:ev_point/views/profile/selfieCamera_screen.dart';
import 'package:ev_point/views/save_station/saved_stations_screen.dart';
import 'package:ev_point/views/station/station_detail_screen.dart';
import 'package:flutter/material.dart';

import '../views/auth/otp_screen.dart';
import '../views/auth/signup_screen.dart';
import '../views/book/charger_list_screen.dart';
import '../views/main/account/menu/my_vehicle_screen.dart';
import '../views/main/booking/cancel_booking_screen.dart';

class AppPages {
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.splashRoute: (context) => const SplashScreen(),
    AppRoutes.onboardRoute: (context) => const OnboardScreen(),
    AppRoutes.signupRoute: (context) => const SignupScreen(),
    AppRoutes.otpRoute: (context) => OtpScreen(),
    AppRoutes.onboardProfileRoute: (context) => OnboardProfile(),
    AppRoutes.selfieRoute: (context) => SelfiecameraScreen(),
    AppRoutes.authOptionRoute: (context) => AuthOptionScreen(),
    AppRoutes.personalizeVehicleRoute: (context) => PersonalizeScreen(),
    AppRoutes.mainRoute: (context) => MainScreen(),
    AppRoutes.stationDetailRoute: (context) => StationDetailScreen(),
    AppRoutes.vehicleListRoute: (context) => VehicleListScreen(),
    AppRoutes.chargerListRoute: (context) => ChargerListScreen(),
    AppRoutes.bookStationRoute: (context) => BookStationScreen(),
    AppRoutes.paymentMethodRoute: (context) => PaymentMethodScreen(),
    AppRoutes.reviewSummaryRoute  :(context) => ReviewSummaryScreen(),
    AppRoutes.savedStationRoute: (context) => SavedStationsScreen(),
    AppRoutes.cancelBookingRoute: (context) => CancelBookingScreen(),
    AppRoutes.chargingProcessRoute: (context) => ChargingProcessScreen(),
    AppRoutes.myVehicleRoute: (context) => MyVehicleScreen(),
    AppRoutes.myPaymentMethodsRoute: (context) => MyPaymentMethodsScreen(),
    AppRoutes.addNewPaymentRoute: (context) => AddNewPaymentScreen(),
  }; 
}
