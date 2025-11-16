// saved_stations_provider.dart
import 'package:flutter/foundation.dart';

class ChargingStation {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewsCount;
  final bool isAvailable;
  final double distance;
  final int travelTime;
  final List<String> chargerTypes;
  final int chargersCount;
  final double latitude;
  final double longitude;
  bool isSaved;

  ChargingStation({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.isAvailable,
    required this.distance,
    required this.travelTime,
    required this.chargerTypes,
    required this.chargersCount,
    required this.latitude,
    required this.longitude,
    this.isSaved = false,
  });
}

class SavedStationsProvider extends ChangeNotifier {
  List<ChargingStation> _savedStations = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ChargingStation> get savedStations => List.unmodifiable(_savedStations);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  SavedStationsProvider() {
    _initializeSampleData();
  }

  // Initialize with sample data
  void _initializeSampleData() {
    _savedStations = [
      ChargingStation(
        id: '1',
        name: 'Walgreens - Brooklyn, NY',
        address: 'Brooklyn, 589 Prospect Avenue',
        rating: 4.5,
        reviewsCount: 128,
        isAvailable: true,
        distance: 1.6,
        travelTime: 5,
        chargerTypes: ['Tesla', 'CCS', 'CHAdeMO', 'Type2', 'Type1', 'GB/T'],
        chargersCount: 6,
        latitude: 40.6782,
        longitude: -73.9442,
        isSaved: true,
      ),
      ChargingStation(
        id: '2',
        name: '108 Prospect Park W',
        address: 'Brooklyn, 108 Prospect Park W',
        rating: 4.3,
        reviewsCount: 104,
        isAvailable: false,
        distance: 2.4,
        travelTime: 9,
        chargerTypes: ['Tesla', 'CCS', 'CHAdeMO', 'Type2'],
        chargersCount: 4,
        latitude: 40.6600,
        longitude: -73.9700,
        isSaved: true,
      ),
      ChargingStation(
        id: '3',
        name: 'EVgo Charging Station',
        address: 'Brooklyn, 234 Atlantic Avenue',
        rating: 4.7,
        reviewsCount: 89,
        isAvailable: true,
        distance: 3.2,
        travelTime: 12,
        chargerTypes: ['CCS', 'CHAdeMO', 'Type2'],
        chargersCount: 5,
        latitude: 40.6845,
        longitude: -73.9765,
        isSaved: true,
      ),
    ];
  }

  // Load saved stations from API
  Future<void> loadSavedStations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await stationRepository.getSavedStations();
      // _savedStations = response;

      await Future.delayed(const Duration(seconds: 1));

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load saved stations: ${e.toString()}';
      notifyListeners();
      debugPrint('Error loading saved stations: $e');
    }
  }

  // Toggle save station
  Future<void> toggleSaveStation(String stationId) async {
    try {
      // TODO: Replace with actual API call
      // await stationRepository.toggleSaveStation(stationId);

      final index = _savedStations.indexWhere((s) => s.id == stationId);
      if (index != -1) {
        // Remove from saved
        _savedStations.removeAt(index);
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to toggle save station: ${e.toString()}';
      notifyListeners();
      debugPrint('Error toggling save station: $e');
    }
  }

  // Add station to saved
  Future<void> addToSaved(ChargingStation station) async {
    try {
      // TODO: Replace with actual API call
      // await stationRepository.addToSaved(station.id);

      if (!_savedStations.any((s) => s.id == station.id)) {
        station.isSaved = true;
        _savedStations.insert(0, station);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to add station to saved: ${e.toString()}';
      notifyListeners();
      debugPrint('Error adding to saved: $e');
    }
  }

  // Remove from saved
  Future<void> removeFromSaved(String stationId) async {
    try {
      // TODO: Replace with actual API call
      // await stationRepository.removeFromSaved(stationId);

      _savedStations.removeWhere((s) => s.id == stationId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to remove from saved: ${e.toString()}';
      notifyListeners();
      debugPrint('Error removing from saved: $e');
    }
  }

  // Search saved stations
  List<ChargingStation> searchStations(String query) {
    if (query.isEmpty) return _savedStations;

    return _savedStations.where((station) {
      return station.name.toLowerCase().contains(query.toLowerCase()) ||
          station.address.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Filter by availability
  List<ChargingStation> filterByAvailability(bool available) {
    return _savedStations.where((s) => s.isAvailable == available).toList();
  }

  // Sort by distance
  void sortByDistance() {
    _savedStations.sort((a, b) => a.distance.compareTo(b.distance));
    notifyListeners();
  }

  // Sort by rating
  void sortByRating() {
    _savedStations.sort((a, b) => b.rating.compareTo(a.rating));
    notifyListeners();
  }
}
