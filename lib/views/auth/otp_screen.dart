import 'dart:async';
import 'dart:developer';

import 'package:ev_point/main.dart';
import 'package:ev_point/routes/app_routes.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/shared_pref.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/back_arrow.dart';
import 'package:ev_point/widgets/dialogbox/custom_dialogbox.dart';
import 'package:ev_point/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
  final otpVerifyController = TextEditingController();
  late List<FocusNode> _focusNodes;
  int get timerText => _seconds ;
  int? otp;
  String userInsertedOtp = "";
  Map<String, dynamic> args = {};
  bool funCall = true;
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    startTimer();
    // getOtp();
  }

  Future<bool> sendOtp(String phoneNumber) async {
    log("sendOtp function called and phone number is $phoneNumber");
  try {
    // await supabase.auth.signInWithOtp(
    //   phone: phoneNumber,
    // );

    // await SupabaseManager().client.auth.signInWithOtp(
    //   phone: phoneNumber,

    // ).then((value) {
    //   log("value after send the otp:");
    // },);

    await SupabaseManager.supabaseClient.auth.signInWithOtp(
      phone: "+91$phoneNumber"
    );

    return true;
  } catch (error) {
    debugPrint('Error sending OTP: $error');
    return false;
  }
}


  Future<void> getOtp() async{
    otp = await SupabaseManager().client.rpc("generate_otp_code").then((value) {
      
      startTimer();
      showSimpleNotification(value.toString());
      return value;
    });
    debugPrint("OTP code: ${otp ?? 0 }");
  }

  void verifyOtp() async{
    log("user inserted otp: $userInsertedOtp");
   
      // log("OTP is verified.");

      // await SupabaseManager.supabaseClient.auth.verifyOTP(
      //   type: OtpType.sms,
      //   phone: "+91${args["phone_number"]}",
      //   token: userInsertedOtp
      // ).then((value) async{
      //   // value.user?.id
      //   log("User data: ${value.user}");
      //   if (value.user != null && value.user!.id.isNotEmpty ) {
      //     await SharedPref().setData("user_id", value.user!.id);  
      //     var userId = SharedPref().getValue("user_id");
      //     log("user id: $userId");
      //   }
        
      // },).catchError( (error) {
      //   log("Verify Otp Error: $error");
      // },);
      
      customDialogBox(
        context: context,
        image: "${Constants.imagePath}sign_up_successfull.png",
        title: "Sign up Successful!",
        subTitle: "Please wait...",
        child: CustomCircularLoader(),
       );
      await SharedPref().setData("userOnboard", "true").then((val){
        debugPrint("user onboarded.. $val");
      });
      WidgetsBinding.instance.addPostFrameCallback((_){
        

        Future.delayed(Duration(seconds: 1), (){
          if(!mounted) return null; 
          var data = {"phone_number" : args["phone_number"] };
          Navigator.pushNamed(context, AppRoutes.onboardProfileRoute, arguments: data);
        });

        
      });
 
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


  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (args.isNotEmpty && funCall) {

        // sendOtp(args["phone_number"]);
        funCall = false;
        
      }
    },);

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
          
              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: List.generate(_otpLength, (index) {
              //       return Padding(
              //         padding: EdgeInsets.all(8.0.r),
              //         child: _buildOtpField(index),
              //       );
              //     }),
              //   ),
              // ),

              OtpTextField(
                numberOfFields: 6,
                textStyle: TextStyle(fontSize: 17.sp),
                // contentPadding: EdgeInsets.all(10.r),
                borderRadius: BorderRadius.circular(10.r),
                showFieldAsBox: true,
                margin: EdgeInsets.only(right: 12.w),
                
                filled: true,
                fillColor: AppColor.greyScale50,
                onSubmit: (value) {
                  userInsertedOtp = value;
                  log("entered otp: $value");
                  verifyOtp();
                  
                },

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
