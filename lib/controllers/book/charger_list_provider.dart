// charger_selection_provider.dart
import 'package:flutter/foundation.dart';

enum ChargerType {
  tesla,
  mennekes,
  chademo,
  ccs1,
  ccs2,
  j1772,
}

enum CurrentType {
  ac,
  dc,
  acdc,
}

class Charger {
  final String id;
  final String name;
  final ChargerType type;
  final CurrentType currentTypeEnum;
  final int maxPower;
  final String? additionalInfo;

  Charger({
    required this.id,
    required this.name,
    required this.type,
    required this.currentTypeEnum,
    required this.maxPower,
    this.additionalInfo,
  });

  String get currentType {
    switch (currentTypeEnum) {
      case CurrentType.ac:
        return 'AC';
      case CurrentType.dc:
        return 'DC';
      case CurrentType.acdc:
        return 'AC/DC';
    }
  }

  String get fullName {
    if (additionalInfo != null && additionalInfo!.isNotEmpty) {
      return '$name ($additionalInfo)';
    }
    return name;
  }

  // Check charger compatibility with vehicle
  bool isCompatibleWith(String vehicleType) {
    // TODO: Implement actual compatibility logic
    return true;
  }
}

class ChargerListProvider extends ChangeNotifier {
  String? _selectedChargerId;
  final List<Charger> _chargers = [];
  bool _isLoading = false;
  String? _errorMessage;

  ChargerListProvider() {
    _initializeChargers();
  }

  // Getters
  String? get selectedChargerId => _selectedChargerId;
  List<Charger> get chargers => List.unmodifiable(_chargers);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Initialize sample chargers (replace with API call)
  void _initializeChargers() {
    _chargers.addAll([
      Charger(
        id: '1',
        name: 'Tesla',
        type: ChargerType.tesla,
        currentTypeEnum: CurrentType.acdc,
        maxPower: 100,
        additionalInfo: 'P...',
      ),
      Charger(
        id: '2',
        name: 'Mennekes',
        type: ChargerType.mennekes,
        currentTypeEnum: CurrentType.ac,
        maxPower: 50,
        additionalInfo: '...',
      ),
      Charger(
        id: '3',
        name: 'CHAdeMO',
        type: ChargerType.chademo,
        currentTypeEnum: CurrentType.dc,
        maxPower: 100,
      ),
      Charger(
        id: '4',
        name: 'CCS1',
        type: ChargerType.ccs1,
        currentTypeEnum: CurrentType.dc,
        maxPower: 50,
      ),
      Charger(
        id: '5',
        name: 'CCS2',
        type: ChargerType.ccs2,
        currentTypeEnum: CurrentType.dc,
        maxPower: 50,
      ),
      Charger(
        id: '6',
        name: 'J1772',
        type: ChargerType.j1772,
        currentTypeEnum: CurrentType.ac,
        maxPower: 50,
        additionalInfo: 'Type 1',
      ),
    ]);
  }

  // Select charger
  void selectCharger(String chargerId) {
    _selectedChargerId = chargerId;
    notifyListeners();
  }

  // Get selected charger object
  Charger? getSelectedCharger() {
    if (_selectedChargerId == null) return null;
    return _chargers.firstWhere(
      (charger) => charger.id == _selectedChargerId,
    );
  }

  // Clear selection
  void clearSelection() {
    _selectedChargerId = null;
    notifyListeners();
  }

  // Load chargers from API
  Future<void> loadChargers({String? vehicleId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await chargerRepository.fetchChargers(vehicleId);
      // _chargers.clear();
      // _chargers.addAll(response);
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load chargers: ${e.toString()}';
      notifyListeners();
      debugPrint('Error loading chargers: $e');
    }
  }

  // Load compatible chargers for selected vehicle
  Future<void> loadCompatibleChargers(String vehicleId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await chargerRepository.fetchCompatibleChargers(vehicleId);
      // _chargers.clear();
      // _chargers.addAll(response);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load compatible chargers: ${e.toString()}';
      notifyListeners();
      debugPrint('Error loading compatible chargers: $e');
    }
  }

  // Filter chargers by type
  List<Charger> filterByType(ChargerType type) {
    return _chargers.where((charger) => charger.type == type).toList();
  }

  // Filter chargers by current type
  List<Charger> filterByCurrentType(CurrentType currentType) {
    return _chargers
        .where((charger) => charger.currentTypeEnum == currentType)
        .toList();
  }

  // Filter chargers by minimum power
  List<Charger> filterByMinPower(int minPower) {
    return _chargers.where((charger) => charger.maxPower >= minPower).toList();
  }

  // Get chargers sorted by power (descending)
  List<Charger> getChargersSortedByPower() {
    final sortedList = List<Charger>.from(_chargers);
    sortedList.sort((a, b) => b.maxPower.compareTo(a.maxPower));
    return sortedList;
  }
}
