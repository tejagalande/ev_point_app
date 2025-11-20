import 'package:ev_point/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/theme/app_color.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogbox/custom_dialogbox.dart';

class CancelBookingProvider extends ChangeNotifier {
  String? _selectedReason;

  final List<String> _reasons = [
    "I encountered an unexpected circumstance",
    "I had a schedule change",
    "I found an alternative charging option",
    "Inconvenient location",
    "I'm having a technical problem",
    "High charging cost",
    "Weather conditions",
    "Lack of amenities",
    "Unavailability of charging spot",
    "Parking availability",
    "Others",
  ];

  String? get selectedReason => _selectedReason;
  List<String> get reasons => _reasons;

  void selectReason(String reason) {
    _selectedReason = reason;
    notifyListeners();
  }

  void submitCancellation(BuildContext context) async{
    if (_selectedReason != null) {
      await customDialogBox(
        context: context,
        image: "${Constants.imagePath}successful_cancelation.png",
        title: "Successful Cancellation!",
        subTitle: "Your booking has been successfully cancelled.",
        subTitleTextAlign: TextAlign.center,
        titleTextAlign: TextAlign.center,
        imageHeight: 150.h,
        child: CustomButton(
          onTapCallback: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Go back to previous screen
          },
          title: "OK",
          buttonColor: AppColor.primary_900,
          textColor: AppColor.white,
          fontSize: 16.sp,
          borderRadius: 35.r,
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a reason")));
    }
  }
}
