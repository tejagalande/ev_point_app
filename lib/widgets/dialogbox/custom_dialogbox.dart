import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Future<void> customDialogBox({
  required BuildContext context,
  required String image,
  required String title,
  required String subTitle,
  required Widget child,
  double? imageHeight,
  TextAlign? subTitleTextAlign,
  TextAlign? titleTextAlign,  }) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
        child: Padding(
          padding:  EdgeInsets.all(20.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                image,
                height: imageHeight ?? 200.h,
              ),
              SizedBox(height: 30.h),
              Text(
                textAlign: subTitleTextAlign,
                title,
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: AppColor.primary_900,
                ),
              ),

              SizedBox(height: 10.h,),

              Text(
                textAlign: subTitleTextAlign,
                subTitle,
                style: TextStyle(
                  fontFamily: Constants.urbanistFont,
                  fontSize: 16.sp,
                  color: AppColor.greyScale900,
                ),
              ),
              // Text(
              //   textAlign: TextAlign.center,
              //   "You will be directed to the homepage.",
              //   style: TextStyle(
              //     fontFamily: Constants.urbanistFont,
              //     fontSize: 16.sp,
              //     color: AppColor.greyScale900,
              //   ),
              // ),
              SizedBox(height: 30.h),
              child,
            ],
          ),
        ),
      );
    },
  );
}
