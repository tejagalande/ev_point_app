import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/my_booking/booking_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/theme/app_color.dart';
import '../../../../widgets/booking_card.dart';

class CanceledBookingsScreen extends StatelessWidget {
  const CanceledBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        final canceledBookings = bookingProvider.canceledBookings;

        return Container(
          color: AppColor.white,
          child:
              canceledBookings.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel,
                          size: 64.w,
                          color: AppColor.greyScale700,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No canceled bookings',
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
                    itemCount: canceledBookings.length,
                    itemBuilder: (context, index) {
                      final booking = canceledBookings[index];
                      return BookingCard(
                        tabIndex: bookingProvider.selectedTabIndex,
                        booking: booking,
                        onView: () {
                          // Navigate to booking details
                        },
   
                      );
                    },
                  ),
        );
      },
    );
  }
}
