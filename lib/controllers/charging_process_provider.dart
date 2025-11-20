import 'package:flutter/foundation.dart';

class ChargingProcessProvider extends ChangeNotifier {
  double _energyKwh = 100;        // kWh
  Duration _chargingTime = const Duration(minutes: 14, seconds: 55);
  int _batteryPercent = 30;      // %
  double _currentAmp = 12.24;    // A
  double _totalFees = 4.27;      // currency

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
}
