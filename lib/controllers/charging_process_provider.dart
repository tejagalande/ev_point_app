import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:ev_point/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChargingProcessProvider extends ChangeNotifier {
  double _energyKwh = 100;        // kWh
  Duration _chargingTime = const Duration(minutes: 14, seconds: 55);
  int _batteryPercent = 30;      // %
  double _currentAmp = 12.24;    // A
  double _totalFees = 4.27;      // currency
  String paymentMethod = "e-wallet";

  double get energyKwh => _energyKwh;
  Duration get chargingTime => _chargingTime;
  int get batteryPercent => _batteryPercent;
  double get currentAmp => _currentAmp;
  double get totalFees => _totalFees;

  void stopCharging() {
    // TODO: implement API call / logic
    // Example: reset values
    _currentAmp = 0;
    notifyListeners();
  }

  // Optional: methods to update values from backend / socket
  void updateCharging({
    double? energyKwh,
    Duration? chargingTime,
    int? batteryPercent,
    double? currentAmp,
    double? totalFees,
  }) {
    if (energyKwh != null) _energyKwh = energyKwh;
    if (chargingTime != null) _chargingTime = chargingTime;
    if (batteryPercent != null) _batteryPercent = batteryPercent;
    if (currentAmp != null) _currentAmp = currentAmp;
    if (totalFees != null) _totalFees = totalFees;
    notifyListeners();
  }

  void chargingComplete(BuildContext context) async{ 

    await customDialogBox(
      context: context, 
      titleTextAlign: TextAlign.center,
      subTitleTextAlign: TextAlign.center,
      imageHeight: 150.h,
      image: "${Constants.imagePath}charging_completed.png", title: "Charging 100% Complete!", subTitle: "A total of \$${_totalFees} has been changed from your $paymentMethod", 
      child: CustomButton(
        
        title: "OK",
        onTapCallback: () => Navigator.pop(context),
        buttonColor: AppColor.primary_900,
        textColor: AppColor.white,
        borderRadius: 30.r,

        )
      );
  }
}
