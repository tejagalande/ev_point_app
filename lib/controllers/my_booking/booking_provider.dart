import 'package:flutter/material.dart';

import '../../models/book/booking_model.dart';

class BookingProvider with ChangeNotifier {
  List<BookingModel> _bookings = [];
  int _selectedTabIndex = 0;
  
  // Getters
  List<BookingModel> get bookings => _bookings;
  int get selectedTabIndex => _selectedTabIndex;
  
  // Get bookings by status
  List<BookingModel> get upcomingBookings {
    return _bookings.where((booking) => booking.status == BookingStatus.upcoming).toList();
  }
  
  List<BookingModel> get completedBookings {
    return _bookings.where((booking) => booking.status == BookingStatus.completed).toList();
  }
  
  List<BookingModel> get canceledBookings {
    return _bookings.where((booking) => booking.status == BookingStatus.canceled).toList();
  }
  
  // Initialize with sample data
  void initializeBookings() {
    _bookings = [
      // Upcoming booking
      BookingModel(
        id: '1',
        date: DateTime(2024, 12, 17, 10, 0),
        locationName: 'Walgreens - Brooklyn, NY',
        address: '589 Prospect Avenue',
        connectorType: 'Tesla (Plug)',
        maxPower: 100,
        duration: const Duration(hours: 1),
        price: 14.25,
        status: BookingStatus.upcoming,
      ),
      // Completed bookings
      BookingModel(
        id: '2',
        date: DateTime(2024, 12, 5, 14, 0),
        locationName: 'ImPark Underhill Garage',
        address: '105 Underhill Ave, Brooklyn',
        connectorType: 'CHAdeMO',
        maxPower: 100,
        duration: const Duration(hours: 1),
        price: 15.50,
        status: BookingStatus.completed,
      ),
      BookingModel(
        id: '3',
        date: DateTime(2024, 11, 20, 9, 0),
        locationName: 'Rapidpark 906 Union St',
        address: '906 Union St, Brooklyn',
        connectorType: 'CCS1',
        maxPower: 50,
        duration: const Duration(hours: 1),
        price: 12.25,
        status: BookingStatus.completed,
      ),
      // Canceled bookings
      BookingModel(
        id: '4',
        date: DateTime(2024, 12, 3, 15, 30),
        locationName: 'MTP Parking',
        address: '755 Kent Ave, Brooklyn',
        connectorType: 'J1772',
        maxPower: 50,
        duration: const Duration(minutes: 30),
        price: 8.50,
        status: BookingStatus.canceled,
      ),
      BookingModel(
        id: '5',
        date: DateTime(2024, 11, 18, 12, 30),
        locationName: 'ImPark',
        address: '353 4th Ave, Brooklyn',
        connectorType: 'Mennekes',
        maxPower: 100,
        duration: const Duration(hours: 1),
        price: 14.25,
        status: BookingStatus.canceled,
      ),
    ];
    notifyListeners();
  }
  
  // Change selected tab
  void changeTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
  
  // Cancel a booking
  void cancelBooking(String bookingId) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings[index] = BookingModel(
        id: _bookings[index].id,
        date: _bookings[index].date,
        locationName: _bookings[index].locationName,
        address: _bookings[index].address,
        connectorType: _bookings[index].connectorType,
        maxPower: _bookings[index].maxPower,
        duration: _bookings[index].duration,
        price: _bookings[index].price,
        status: BookingStatus.canceled,
      );
      notifyListeners();
    }
  }
  
  // Book again (create a new upcoming booking based on a previous one)
  void bookAgain(String bookingId) {
    final booking = _bookings.firstWhere((booking) => booking.id == bookingId);
    final newBooking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now().add(const Duration(days: 7)),
      locationName: booking.locationName,
      address: booking.address,
      connectorType: booking.connectorType,
      maxPower: booking.maxPower,
      duration: booking.duration,
      price: booking.price,
      status: BookingStatus.upcoming,
    );
    _bookings.add(newBooking);
    notifyListeners();
  }
}