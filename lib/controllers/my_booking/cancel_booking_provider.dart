import 'package:flutter/material.dart';

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

  void submitCancellation(BuildContext context) {
    if (_selectedReason != null) {
      // Logic to submit cancellation
      // For now, just pop the screen
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking cancelled successfully")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a reason")));
    }
  }
}
