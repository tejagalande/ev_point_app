import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../loader.dart';

Future<Widget> customDialogBox(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
        child: Padding(
          padding:  EdgeInsets.all(20.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "${Constants.imagePath}sign_up_successfull.png",
                height: 200.h,
              ),
              SizedBox(height: 30.h),
              Text(
                "Sign up Successful!",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontWeight: FontWeight.w800,
                  fontSize: 24.sp,
                  color: AppColor.primary_900,
                ),
              ),
              Text(
                "Please wait...",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 16.sp,
                  color: AppColor.greyScale900,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "You will be directed to the homepage.",
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 16.sp,
                  color: AppColor.greyScale900,
                ),
              ),
              SizedBox(height: 30.h),
              CustomCircularLoader(),
            ],
          ),
        ),
      );
    },
  );
}
