import 'dart:async';

import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/utils/theme/text_styles.dart';
import 'package:ev_point/widgets/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  String countryCode;
  String phoneNumber;
  OtpScreen({super.key, required this.countryCode, required this.phoneNumber});

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
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    startTimer();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index + 1 < _otpLength) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus(); // All done
      }
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
      }
    });
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      
      width: 50,
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
            fillColor: AppColor.greyScale50,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.greyScale200, )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.greyScale200, )
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
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: GestureDetector(onTap: () {}, child: backArrow()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              SizedBox(height: 10,),
              Text("OTP code verification 🔐", style: TextStyles.h3Bold32),
              Text(
                "We have sent an OTP code to phone number ${widget.phoneNumber}. Enter the OTP code below to continue.",
                style: TextStyles.bodyXlargeRegular18,
              ),
          
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_otpLength, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildOtpField(index),
                    );
                  }),
                ),
              ),
          
              Center(
                child: Text(
                  "Didn\'t receive otp code?",
                  style: TextStyle(
                    color: AppColor.black,
                    fontFamily: Constants.urbanistFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          
              Center(
                child: GestureDetector(
                  onTap: () {
                    
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: AppColor.black,
                        fontFamily: Constants.urbanistFont,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(text: "You can resend code in "),
                        TextSpan(
                          style: TextStyle(
                            color: AppColor.primary_900,
                            fontFamily: Constants.urbanistFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          text: "$timerText",
                        ),
                        TextSpan(text: " s "),
                        TextSpan(text: timerText > 0 ? "" : "Resend", style: TextStyle(color: AppColor.primary_900, decoration: TextDecoration.underline, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: Constants.urbanistFont))
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
    super.dispose();
  }
}
