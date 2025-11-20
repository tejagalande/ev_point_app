import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/my_booking/booking_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/theme/app_color.dart';
import '../../../../widgets/booking_card.dart';

class CompletedBookingsScreen extends StatelessWidget {
  const CompletedBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        final completedBookings = bookingProvider.completedBookings;

        return Container(
          color: AppColor.white,
          child:
              completedBookings.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 64.w,
                          color: AppColor.greyScale700,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No completed bookings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.greyScale700,
                            fontFamily: Constants.urbanistFont,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemCount: completedBookings.length,
                    itemBuilder: (context, index) {
                      final booking = completedBookings[index];
                      return BookingCard(
                        booking: booking,
                        onView: () {
                          // Navigate to booking details
                        },
                        onBookAgain: () {
                          bookingProvider.bookAgain(booking.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Booking created successfully',
                                style: TextStyle(
                                  fontFamily: Constants.urbanistFont,
                                ),
                              ),
                              backgroundColor: AppColor.green,
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
