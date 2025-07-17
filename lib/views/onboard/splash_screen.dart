import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/views/onboard/onboard_screen.dart';
import 'package:ev_point/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Android settings
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS settings (optional)
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  @override
  void initState() {
    // TODO: implement initState



    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      
    // Initialize settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );
    
     await requestNotificationPermissions();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    },);
    _sendToOnboard();
  }

  Future<void> requestNotificationPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      final granted = await androidPlugin?.requestNotificationsPermission();
      print('Android notification permission granted: $granted');
    }

    if (Platform.isIOS) {
      final iosPlugin =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('iOS notification permission granted: $granted');
    }
  }

  _sendToOnboard() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnboardScreen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      body: Stack(
        // alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20.0,
              children: [
                SvgPicture.asset(
                  "${Constants.iconPath}logo_evPoint.svg",
                  height: 120.h,
                ),

                Text("EVPoint", style: TextStyles.h2Bold40),
              ],
            ),
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: CustomCircularLoader(),
          ),
        ],
      ),
    );
  }
}
