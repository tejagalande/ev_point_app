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
  
  const BookingCard({
    Key? key,
    required this.booking,
    this.onView,
    this.onCancel,
    this.onBookAgain,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.greyScale50,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and Time
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16.w,
                color: AppColor.greyScale900,
              ),
              SizedBox(width: 8.w),
              Text(
                booking.formattedDate,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyScale700,
                  fontFamily: Constants.urbanistFont,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.access_time,
                size: 16.w,
                color: AppColor.greyScale900,
              ),
              SizedBox(width: 8.w),
              Text(
                booking.formattedTime,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyScale700,
                  fontFamily: Constants.urbanistFont,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16.w,
                color: AppColor.greyScale900,
              ),
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
                      Constants.connectorTypes[booking.connectorType] ?? booking.connectorType,
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
          
          // Status-specific content
          if (booking.status == BookingStatus.upcoming) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16.w,
                    color: AppColor.orange,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Please insert the charging connector within 15 minutes, or the booking will be automatically canceled.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.orange,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Action buttons
          if (onView != null || onCancel != null || onBookAgain != null) ...[
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onView != null)
                  TextButton(
                    onPressed: onView,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(color: AppColor.greyScale200),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ),
                if (onCancel != null) ...[
                  SizedBox(width: 12.w),
                  TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      backgroundColor: AppColor.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Cancel Booking',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ),
                ],
                if (onBookAgain != null) ...[
                  SizedBox(width: 12.w),
                  TextButton(
                    onPressed: onBookAgain,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      backgroundColor: AppColor.primary_900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Book Again',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: Constants.urbanistFont,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}