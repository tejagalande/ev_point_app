import 'dart:async';

import 'package:ev_point/main.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/shared_pref.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/back_arrow.dart';
import 'package:ev_point/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../onboard/splash_screen.dart';

class OtpScreen extends StatefulWidget {

  OtpScreen({super.key,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final int _otpLength = 4;
  int _seconds = 60;
  Timer? _timer;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int get timerText => _seconds ;
  int? otp;
  String userInsertedOtp = "";
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    startTimer();
    getOtp();
  }

  Future<void> getOtp() async{
    otp = await SupabaseManager().client.rpc("generate_otp_code").then((value) {
      
      startTimer();
      showSimpleNotification(value.toString());
      return value;
    });
    debugPrint("OTP code: ${otp ?? 0 }");
  }

  void verifyOtp(){
    debugPrint("user inserted otp: $userInsertedOtp");
    if( userInsertedOtp.compareTo(otp!.toString()) == 0){
      debugPrint("OTP is verified.");
      
      customDialogBox(context);
      SharedPref().setData("userOnboard", "true").then((val){
        debugPrint("user onboarded.. $val");
      });
      WidgetsBinding.instance.addPostFrameCallback((_){
        

        Future.delayed(Duration(seconds: 1), (){
          if(!mounted) return null; 
          Navigator.pushNamed(context, AppRoutes.onboardProfileRoute);
        });

        
      });
    }
    else{
      debugPrint("OTP is invalid.");
    }
  }

  Future<void> showSimpleNotification(String otpCode) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'EVPoint',
      "Your OTP code is $otpCode",
      notificationDetails,
    );
  }

  void _onChanged(String value, int index) {
    
    if (value.length == 1) {
      if (index + 1 < _otpLength) {
        
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus(); // All done
        
      }
      userInsertedOtp += value;
      verifyOtp();
    }
  }

  void _onKey(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        _controllers[index - 1].clear();
      }
    }
  }

  void startTimer() {
    if (_timer != null) _timer!.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        _timer = null;
        
        
      }
    });
  }

  Widget _buildOtpField(int index) {
    

    return SizedBox(
      
      width: 50.w,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // A dummy node for RawKeyboardListener
        onKey: (event) => _onKey(event, index),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyles.h4Bold24,
          
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: _focusNodes[index].hasFocus ? AppColor.primary_900.withAlpha(40) : AppColor.greyScale50,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColor.greyScale200, )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: _focusNodes[index].hasFocus ? AppColor.primary_900 : AppColor.greyScale200, )
          )
          ),
          
          onChanged: (value) => _onChanged(value, index),
          
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: GestureDetector(onTap: () {
          Navigator.pop(context);
        }, child: backArrow()),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  15.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30.h,
            children: [
              SizedBox(height: 10.0.h,),
              Text(Constants.otpCodeVerify, style: TextStyles.h3Bold32),
              Text(
                "We have sent an OTP code to phone number ${args["phone_number"]}. Enter the OTP code below to continue.",
                style: TextStyles.bodyXlargeRegular18,
              ),
          
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_otpLength, (index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: _buildOtpField(index),
                    );
                  }),
                ),
              ),
          
              Center(
                child: Text(
                  Constants.didNotReceiveOtp,
                  style: TextStyle(
                    color: AppColor.black,
                    fontFamily: Constants.urbanistFont,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          

            //  resend text
              Center(
                child: GestureDetector(
                  onTap: () {
                    if(_seconds == 0){
                        _controllers.forEach((c) => c.clear() );
                        _seconds = 60;
                        userInsertedOtp = "";
                        getOtp();
                        // _focusNodes.forEach((f) => f. );
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColor.black,
                        fontFamily: Constants.urbanistFont,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: Constants.youCanResendCode),
                        TextSpan(
                          style: TextStyle(
                            color: AppColor.primary_900,
                            fontFamily: Constants.urbanistFont,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          text: "$timerText",
                        ),
                        TextSpan(text: " s "),
                        TextSpan(text: timerText > 0 ? "" : Constants.reSend, style: TextStyle(color: AppColor.primary_900, decoration: TextDecoration.underline, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: Constants.urbanistFont))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }
}
