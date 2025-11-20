import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/book/booking_model.dart';
import '../utils/constants.dart';
import '../utils/theme/app_color.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onView;
  final VoidCallback? onCancel;
  final VoidCallback? onBookAgain;
  final int tabIndex;

  const BookingCard({
    super.key,
    required this.booking,
    this.onView,
    this.onCancel,
    this.onBookAgain,
    required this.tabIndex
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.greyScale200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(
                  //   Icons.calendar_today,
                  //   size: 16.w,
                  //   color: AppColor.greyScale900,
                  // ),
                  // SizedBox(width: 8.w),
                  Text(
                    booking.formattedDate,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.greyScale800,
                      fontFamily: Constants.urbanistFont,
                    ),
                  ),
                  // SizedBox(width: 16.w),
                  // Icon(Icons.access_time, size: 16.w, color: AppColor.greyScale900),
                  // SizedBox(width: 8.w),
                  Text(
                    booking.formattedTime,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.greyScale800,
                      fontFamily: Constants.urbanistFont,
                    ),
                  ),
                ],
              ),

              tabIndex == 0 ? Row(
                spacing: 10.w,
                children: [
                  Text("Remind Me",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.greyScale700,
                    fontFamily: Constants.urbanistFont,
                  ),),
                  Switch(
                    trackColor: WidgetStatePropertyAll(AppColor.primary_900),
                    // padding: EdgeInsets.only( right: 20.w),
                    value: true, 
                    onChanged:(value) {
                    
                  },)
                ],
              ) : Container(
                padding: EdgeInsets.all(5).r,
                decoration: BoxDecoration(
                  color: AppColor.primary_900,
                  
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text("Available", style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                  fontFamily: Constants.urbanistFont,
                ),))
            ],
          ),
          SizedBox(height: 12.h),
          Divider(thickness: 0.5),

          // Location
          Row(
            children: [
              Icon(Icons.location_on, size: 16.w, color: AppColor.greyScale900),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  booking.locationName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.greyScale700,
                    fontFamily: Constants.urbanistFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: Text(
              booking.address,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.greyScale700,
                fontFamily: Constants.urbanistFont,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          Divider(thickness: 0.5),

          // Charger Details
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.greyScale50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Connector Type
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connector',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.greyScale700,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      Constants.connectorTypes[booking.connectorType] ??
                          booking.connectorType,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyScale900,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ],
                ),

                // Max Power
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max Power',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.greyScale700,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${booking.maxPower} kW',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyScale900,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ],
                ),

                // Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.greyScale700,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      booking.formattedDuration,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyScale900,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ],
                ),

                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.greyScale700,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${booking.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyScale900,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(thickness: 0.5),

          // Action buttons
          if (onView != null || onCancel != null || onBookAgain != null) ...[
            SizedBox(height: 16.h),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10.w,
              children: [
                if (onCancel != null) ...[
                  // SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      onTapCallback: onCancel,
                      title: 'Cancel Booking',
                      buttonColor: AppColor.white,
                      padding: EdgeInsets.symmetric(vertical: 7.h ),
                      textColor: AppColor.primary_900,
                      fontSize: 16.sp,
                      borderRadius: 25.r,
                      border: Border.all(color: AppColor.primary_900, width: 2),
                    ),
                  ),
                ],

                if (onView != null)
                  Expanded(
                    child: CustomButton(
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      onTapCallback: onView,
                      title: 'View',
                      buttonColor: tabIndex == 0 ? AppColor.primary_900 : AppColor.white,
                      textColor: tabIndex == 0 ? AppColor.white : AppColor.primary_900, 
                      border: tabIndex == 1 || tabIndex == 2 ? Border.all(color: AppColor.primary_900, width: 2) : null,
                      fontSize: 16.sp,
                      borderRadius: 25.r,
                    ),
                  ),

                if (onBookAgain != null) ...[
                  // SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      onTapCallback: onBookAgain,
                      title: 'Book Again',
                      buttonColor: AppColor.primary_900,
                      textColor: AppColor.white,
                      fontSize: 16.sp,
                      borderRadius: 25.r,
                    ),
                  ),
                ],
              ],
            ),
          ],

          // here

          // Status-specific content
          if (booking.status == BookingStatus.upcoming) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.info.withAlpha(20),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 16.w, color: AppColor.orange),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Please insert the charging connector within 15 minutes, or the booking will be automatically canceled.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.orange,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
