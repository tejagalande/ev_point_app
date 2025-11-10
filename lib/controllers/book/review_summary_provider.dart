
import 'package:flutter/material.dart';

// Model classes
class VehicleSummary {
  final String id;
  final String brand;
  final String model;
  final String variant;
  final Color color;

  VehicleSummary({
    required this.id,
    required this.brand,
    required this.model,
    required this.variant,
    required this.color,
  });

  String get modelDetails => '$model · $variant';
}

class ChargingStationSummary {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  ChargingStationSummary({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class ChargerSummary {
  final String id;
  final String name;
  final String currentType;
  final int maxPower;

  ChargerSummary({
    required this.id,
    required this.name,
    required this.currentType,
    required this.maxPower,
  });
}

class PaymentMethodSummary {
  final String id;
  final String name;
  final String? balance;

  PaymentMethodSummary({
    required this.id,
    required this.name,
    this.balance,
  });
}

class ReviewSummaryProvider extends ChangeNotifier {
  VehicleSummary? _selectedVehicle;
  ChargingStationSummary? _chargingStation;
  ChargerSummary? _selectedCharger;
  PaymentMethodSummary? _selectedPaymentMethod;
  
  String? _bookingDate;
  String? _arrivalTime;
  String? _chargingDuration;
  
  double _amountEstimation = 0.0;
  double _tax = 0.0;
  double _totalAmount = 0.0;
  
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  VehicleSummary? get selectedVehicle => _selectedVehicle;
  ChargingStationSummary? get chargingStation => _chargingStation;
  ChargerSummary? get selectedCharger => _selectedCharger;
  PaymentMethodSummary? get selectedPaymentMethod => _selectedPaymentMethod;
  
  String? get bookingDate => _bookingDate;
  String? get arrivalTime => _arrivalTime;
  String? get chargingDuration => _chargingDuration;
  
  double get amountEstimation => _amountEstimation;
  double get tax => _tax;
  double get totalAmount => _totalAmount;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isBookingComplete =>
      _selectedVehicle != null &&
      _chargingStation != null &&
      _selectedCharger != null &&
      _selectedPaymentMethod != null &&
      _bookingDate != null &&
      _arrivalTime != null &&
      _chargingDuration != null;

  // Initialize with sample data
  ReviewSummaryProvider() {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _selectedVehicle = VehicleSummary(
      id: '1',
      brand: 'Tesla',
      model: 'Model S',
      variant: '40',
      color: Colors.red,
    );

    _chargingStation = ChargingStationSummary(
      id: '1',
      name: 'Walgreens - Brooklyn, NY',
      address: 'Brooklyn, 589 Prospect Avenue',
      latitude: 40.6782,
      longitude: -73.9442,
    );

    _selectedCharger = ChargerSummary(
      id: '1',
      name: 'Tesla (Plug)',
      currentType: 'AC/DC',
      maxPower: 100,
    );

    _selectedPaymentMethod = PaymentMethodSummary(
      id: '1',
      name: 'E-Wallet',
      balance: '\$957.50',
    );

    _bookingDate = 'Dec 17, 2024';
    _arrivalTime = '10:00 AM';
    _chargingDuration = '1 Hour';

    _calculatePricing();
  }

  // Set vehicle
  void setVehicle(VehicleSummary vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }

  // Set charging station
  void setChargingStation(ChargingStationSummary station) {
    _chargingStation = station;
    notifyListeners();
  }

  // Set charger
  void setCharger(ChargerSummary charger) {
    _selectedCharger = charger;
    _calculatePricing();
    notifyListeners();
  }

  // Set payment method
  void setPaymentMethod(PaymentMethodSummary paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  // Set booking date
  void setBookingDate(String date) {
    _bookingDate = date;
    notifyListeners();
  }

  // Set arrival time
  void setArrivalTime(String time) {
    _arrivalTime = time;
    notifyListeners();
  }

  // Set charging duration
  void setChargingDuration(String duration) {
    _chargingDuration = duration;
    _calculatePricing();
    notifyListeners();
  }

  // Calculate pricing based on charger power and duration
  void _calculatePricing() {
    if (_selectedCharger == null || _chargingDuration == null) return;

    // Extract hours from duration string (e.g., "1 Hour" -> 1)
    final hours = int.tryParse(_chargingDuration!.split(' ')[0]) ?? 1;
    
    // Calculate based on power (kW) and duration (hours)
    // Example: $0.15 per kWh
    final pricePerKwh = 0.15;
    _amountEstimation = _selectedCharger!.maxPower * hours * pricePerKwh;
    
    // Tax calculation (0% in this case)
    _tax = 0.0;
    
    // Total amount
    _totalAmount = _amountEstimation + _tax;
  }

  // Load booking summary data
  Future<void> loadBookingSummary({
    required String vehicleId,
    required String stationId,
    required String chargerId,
    required String paymentMethodId,
    required DateTime bookingDate,
    required TimeOfDay arrivalTime,
    required int duration,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API calls
      // final vehicleData = await api.getVehicle(vehicleId);
      // final stationData = await api.getChargingStation(stationId);
      // final chargerData = await api.getCharger(chargerId);
      // final paymentData = await api.getPaymentMethod(paymentMethodId);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _bookingDate = '${bookingDate.month}/${bookingDate.day}/${bookingDate.year}';
      _arrivalTime = '${arrivalTime.hour}:${arrivalTime.minute.toString().padLeft(2, '0')}';
      _chargingDuration = '$duration ${duration == 1 ? 'Hour' : 'Hours'}';

      _calculatePricing();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load booking summary: ${e.toString()}';
      notifyListeners();
      debugPrint('Error loading booking summary: $e');
    }
  }

  // Confirm booking
  Future<bool> confirmBooking() async {
    if (!isBookingComplete) {
      _errorMessage = 'Please complete all booking details';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await api.createBooking({
      //   'vehicleId': _selectedVehicle!.id,
      //   'stationId': _chargingStation!.id,
      //   'chargerId': _selectedCharger!.id,
      //   'paymentMethodId': _selectedPaymentMethod!.id,
      //   'bookingDate': _bookingDate,
      //   'arrivalTime': _arrivalTime,
      //   'duration': _chargingDuration,
      //   'totalAmount': _totalAmount,
      // });

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      _isLoading = false;
      notifyListeners();
      
      debugPrint('Booking confirmed successfully');
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to confirm booking: ${e.toString()}';
      notifyListeners();
      debugPrint('Error confirming booking: $e');
      return false;
    }
  }

  // Get booking summary for display or sharing
  Map<String, dynamic> getBookingSummaryData() {
    return {
      'vehicle': {
        'brand': _selectedVehicle?.brand,
        'model': _selectedVehicle?.modelDetails,
      },
      'station': {
        'name': _chargingStation?.name,
        'address': _chargingStation?.address,
      },
      'charger': {
        'name': _selectedCharger?.name,
        'type': _selectedCharger?.currentType,
        'power': _selectedCharger?.maxPower,
      },
      'booking': {
        'date': _bookingDate,
        'time': _arrivalTime,
        'duration': _chargingDuration,
      },
      'pricing': {
        'amount': _amountEstimation,
        'tax': _tax,
        'total': _totalAmount,
      },
      'payment': {
        'method': _selectedPaymentMethod?.name,
      },
    };
  }

  // Reset all data
  void resetSummary() {
    _selectedVehicle = null;
    _chargingStation = null;
    _selectedCharger = null;
    _selectedPaymentMethod = null;
    _bookingDate = null;
    _arrivalTime = null;
    _chargingDuration = null;
    _amountEstimation = 0.0;
    _tax = 0.0;
    _totalAmount = 0.0;
    notifyListeners();
  }
}
