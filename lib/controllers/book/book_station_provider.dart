// booking_date_time_provider.dart
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookStationProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
    DateTime? _currentDate;
  int _selectedDuration = 1;

  // Getters
  DateTime? get selectedDate => _selectedDate;
  DateTime? get currentDate => _currentDate;
  TimeOfDay? get selectedTime => _selectedTime;
  int get selectedDuration => _selectedDuration;

  bool get isBookingValid =>
      _selectedDate != null && _selectedTime != null && _selectedDuration > 0;

  // Initialize with default values
  BookStationProvider() {
    // _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  }

  // Select date
  void selectDate(DateTime date) {
    // _selectedDate = DateTime(date.year, date.month, date.day);
    _currentDate = date;
    notifyListeners();
    log('Selected date: $_currentDate');
  }

  // Set time
  void setTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
    debugPrint('Selected time: $time');
  }

  // Update duration
  void updateDuration(int duration) {
    _selectedDuration = duration;
    notifyListeners();
  }

  // Get formatted time string
  String getFormattedTime() {
    if (_selectedTime == null) return '';
    
    final hour = _selectedTime!.hourOfPeriod == 0 
        ? 12 
        : _selectedTime!.hourOfPeriod;
    final minute = _selectedTime!.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Get booking details
  Map<String, dynamic> getBookingDetails() {
    return {
      'date': _selectedDate,
      'time': _selectedTime,
      'duration': _selectedDuration,
      'dateTimeString': _getDateTimeString(),
    };
  }

  // Get combined date time string
  String _getDateTimeString() {
    if (_selectedDate == null || _selectedTime == null) return '';
    
    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  // Reset booking
  void resetBooking() {
    _selectedDate = null;
    _selectedTime = const TimeOfDay(hour: 10, minute: 0);
    _selectedDuration = 1;
    notifyListeners();
  }
}
