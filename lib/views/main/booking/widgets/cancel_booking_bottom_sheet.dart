import 'package:ev_point/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/theme/app_color.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_button.dart';

class CancelBookingBottomSheet extends StatelessWidget {
  final VoidCallback onCancel;

  const CancelBookingBottomSheet({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.r),
          topRight: Radius.circular(45.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 50.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.greyScale300,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          SizedBox(height: 15.h),

          // Title
          Text(
            'Cancel Booking',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.error,
              fontFamily: Constants.urbanistFont,
            ),
          ),
          SizedBox(height: 15.h),

          Divider(height: 1, color: AppColor.greyScale200),
          SizedBox(height: 15.h),

          // Message
          Text(
            'Are you sure you want to cancel the booking?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.greyScale900,
              fontFamily: Constants.urbanistFont,
            ),
          ),
          SizedBox(height: 24.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTapCallback: () => Navigator.pop(context),
                  title: "No, Don't Cancel",
                  buttonColor: AppColor.primary_100, // Light green
                  textColor: AppColor.primary_900, // Dark green
                  fontSize: 16.sp,
                  boldText: true,
                  borderRadius: 30.r,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  onTapCallback: () {
                    

                    onCancel(); // Trigger cancellation
                    Navigator.pushNamed(context, AppRoutes.cancelBookingRoute);
                  },
                  title: "Yes, Cancel",
                  buttonColor: AppColor.primary_900, // Green
                  textColor: Colors.white,
                  
                  isShadow: true,
                  boldText: true,
                  fontSize: 16.sp,
                  borderRadius: 30.r,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
