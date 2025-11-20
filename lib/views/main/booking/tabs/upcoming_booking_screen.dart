import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/my_booking/booking_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/theme/app_color.dart';
import '../../../../widgets/booking_card.dart';
import '../widgets/cancel_booking_bottom_sheet.dart';

class UpcomingBookingsScreen extends StatefulWidget {
  const UpcomingBookingsScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingBookingsScreen> createState() => _UpcomingBookingsScreenState();
}

class _UpcomingBookingsScreenState extends State<UpcomingBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        final upcomingBookings = bookingProvider.upcomingBookings;

        return Container(
          color: AppColor.white,
          child:
              upcomingBookings.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64.w,
                          color: AppColor.greyScale700,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No upcoming bookings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.greyScale700,
                            fontFamily: Constants.urbanistFont,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Book a charging station now',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.greyScale900,
                            fontFamily: Constants.urbanistFont,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to booking screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary_900,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                              fontFamily: Constants.urbanistFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemCount: upcomingBookings.length,
                    itemBuilder: (context, index) {
                      final booking = upcomingBookings[index];
                      return BookingCard(
                        
                        booking: booking,
                        tabIndex: bookingProvider.selectedTabIndex,
                        onView: () {
                          // Navigate to booking details
                        },
                        onCancel: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder:
                                (context) => CancelBookingBottomSheet(
                                  onCancel: () {
                                    bookingProvider.cancelBooking(booking.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Booking canceled successfully',
                                          style: TextStyle(
                                            fontFamily: Constants.urbanistFont,
                                          ),
                                        ),
                                        backgroundColor: AppColor.green,
                                      ),
                                    );
                                  },
                                ),
                          );
                        },
                      );
                    },
                  ),
        );
      },
    );
  }
}
