import 'dart:developer';

import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:ev_point/controllers/book/book_station_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';


class BookStationScreen extends StatelessWidget {
  const BookStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookStationProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Booking',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Consumer<BookStationProvider>(
          builder: (context, provider, child) {
            return Column(
              spacing: 10.h,
              children: [
                _SectionTitle(title: "Select Date"),

                // Calendar 
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.greyScale50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColor.greyScale200 )
                    
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CalendarCarousel<Event>(
                    onDayPressed:
                        (DateTime date, List<Event> events) =>
                            provider.selectDate(date),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    // viewportFraction: 1,
                    // dayPadding: 1.5,
                    selectedDayButtonColor: AppColor.primary_900,
                    thisMonthDayBorderColor: Colors.grey,
                    pageSnapping: true,
                  
                    //      weekDays: null, /// for pass null when you do not want to render weekDays
                    //  headerText: "Custom Header",
                    weekFormat: false,
                    // markedDatesMap: _markedDateMap,
                    height: 420.0,
                    selectedDateTime: provider.currentDate,
                    daysHaveCircularBorder: null,
                  
                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),

                // time picker

            _TimePickerDropdown(provider: provider)
                
              ],
            );
          },
        ),
      ),
    );
  }
}

// All child widgets should be StatelessWidget
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.greyScale900,
        fontFamily: Constants.urbanistFont
      ),
    );
  }
}


class _TimePickerDropdown extends StatelessWidget {
  final BookStationProvider provider;

  const _TimePickerDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
    ),
    child: InkWell(
      onTap: () => _showTimePickerBottomSheet(context),
      child: Consumer<BookStationProvider>(
        builder:(context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.getFormattedTime(),
              style: const TextStyle(  
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text( 
                  value.selectedTime != null
                      ? (provider.selectedTime!.hour >= 12 ? 'PM' : 'AM')
                      : 'AM',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00C853),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
      )
    ),
        );
  }

  void _showTimePickerBottomSheet(BuildContext context) async {
      showModalBottomSheet(
        backgroundColor: AppColor.white,
                context: context,
                clipBehavior: Clip.antiAlias,
                
                builder: (BuildContext context) {
                  return ChangeNotifierProvider(
                    create:(context) => BookStationProvider(),
                    builder: (context, child) {
                      return SizedBox(
                    height: 250.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: CustomButton(
                            // margin: EdgeInsets.zero,
                            fontSize: 18.sp,
                            title: "Done", 
                            buttonColor: AppColor.white, 
                            textColor: AppColor.primary_900,
                          onTapCallback: () {
                            Navigator.pop(context);
                            var formattedTime = context.read<BookStationProvider>().getFormattedTime();
                            log("formatted time: $formattedTime");
                          },),
                        ),
                        Center(
                           child :       TimePickerSpinner(
                                      locale: const Locale('en', ''),
                                      time: DateTime.now(),
                                      is24HourMode: false,
                                      isShowSeconds: false,
                                      itemHeight: 60.h,
                                      normalTextStyle:  TextStyle(
                                        fontSize: 24,
                                      ),
                                      highlightedTextStyle:
                                          const TextStyle(fontSize: 24, color: Colors.blue),
                                      isForce2Digits: true,
                                      hapticFeedback: true,
                                      onTimeChange: (time) {
                                        log("selected Time: $time");
                                        context.read<BookStationProvider>().setTime(TimeOfDay.fromDateTime(time));
                                        // setState(() {
                                        //   dateTime = time;
                                        // });
                                      },
                                    ),
                        ),
                      ],
                    ),
                  );
                    },
                  );
                },
              );

  }
}

class _DurationPickerDropdown extends StatelessWidget {
  final BookStationProvider provider;

  const _DurationPickerDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
      child: InkWell(
        onTap: () => _showDurationPicker(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                provider.selectedDuration.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    provider.selectedDuration == 1 ? 'Hour' : 'Hours',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00C853),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDurationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      'Select Duration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Color(0xFF00C853)),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      Provider.of<BookStationProvider>(
                        context,
                        listen: false,
                      ).updateDuration(index + 1);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final duration = index + 1;
                        return Center(
                          child: Text(
                            '$duration ${duration == 1 ? 'Hour' : 'Hours'}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        );
                      },
                      childCount: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7EC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF00C853),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'i',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'You can only book available times. Unavailable time means someone else has booked it.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _ContinueButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: onPressed != null ? Colors.white : Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
