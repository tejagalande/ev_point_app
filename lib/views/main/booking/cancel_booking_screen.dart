import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controllers/my_booking/cancel_booking_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme/app_color.dart';
import '../../../widgets/custom_button.dart';

class CancelBookingScreen extends StatelessWidget {
  const CancelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CancelBookingProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.greyScale900),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Cancel Booking',
            style: TextStyle(
              color: AppColor.greyScale900,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: Constants.urbanistFont,
            ),
          ),
        ),
        body: Consumer<CancelBookingProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose the reason for your cancellation:',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.greyScale900,
                            fontFamily: Constants.urbanistFont,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ...provider.reasons.map((reason) {
                          final isSelected = provider.selectedReason == reason;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GestureDetector(
                              onTap: () => provider.selectReason(reason),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColor.primary_900
                                                : AppColor.primary_900,
                                        width: 2.w,
                                      ),
                                    ),
                                    child:
                                        isSelected
                                            ? Center(
                                              child: Container(
                                                width: 12.w,
                                                height: 12.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.primary_900,
                                                ),
                                              ),
                                            )
                                            : null,
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Text(
                                      reason,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.greyScale900,
                                        fontFamily: Constants.urbanistFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: CustomButton(
                    onTapCallback: () => provider.submitCancellation(context),
                    title: "Submit",
                    buttonColor: AppColor.primary_900,
                    textColor: Colors.white,
                    fontSize: 16.sp,
                    borderRadius: 30.r,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
