// vehicle_selection_provider.dart
import 'package:flutter/foundation.dart';

class Vehicle {
  final String id;
  final String brand;
  final String model;
  final String variant;
  final String imagePath;
  final VehicleColor color;

  Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.variant,
    required this.imagePath,
    required this.color,
  });

  String get modelDetails => '$model · $variant';
}

enum VehicleColor {
  red,
  blue,
  gray,
  yellow,
  darkBlue,
  silver,
}

class VehicleListProvider extends ChangeNotifier {
  String? _selectedVehicleId;
  final List<Vehicle> _vehicles = [];

  VehicleListProvider() {
    _initializeVehicles();
  }

  // Getters
  String? get selectedVehicleId => _selectedVehicleId;
  List<Vehicle> get vehicles => List.unmodifiable(_vehicles);

  // Initialize sample vehicles (replace with API call)
  void _initializeVehicles() {
    _vehicles.addAll([
      Vehicle(
        id: '1',
        brand: 'Tesla',
        model: 'Model S',
        variant: '40',
        imagePath: 'assets/vehicles/tesla_red.png',
        color: VehicleColor.red,
      ),
      Vehicle(
        id: '2',
        brand: 'Audi',
        model: 'e-Tron',
        variant: 'Prestige',
        imagePath: 'assets/vehicles/audi_blue.png',
        color: VehicleColor.blue,
      ),
      Vehicle(
        id: '3',
        brand: 'Porsche',
        model: 'Taycan',
        variant: 'Turbo S',
        imagePath: 'assets/vehicles/porsche_gray.png',
        color: VehicleColor.gray,
      ),
      Vehicle(
        id: '4',
        brand: 'Ford',
        model: 'Mustang Mach-E',
        variant: 'GT',
        imagePath: 'assets/vehicles/ford_yellow.png',
        color: VehicleColor.yellow,
      ),
      Vehicle(
        id: '5',
        brand: 'Volkswagen',
        model: 'ID.4',
        variant: '1st Edition',
        imagePath: 'assets/vehicles/vw_blue.png',
        color: VehicleColor.darkBlue,
      ),
      Vehicle(
        id: '6',
        brand: 'Kia',
        model: 'Niro EV',
        variant: 'EX Premium',
        imagePath: 'assets/vehicles/kia_silver.png',
        color: VehicleColor.silver,
      ),
    ]);
  }

  // Select vehicle
  void selectVehicle(String vehicleId) {
    _selectedVehicleId = vehicleId;
    notifyListeners();
  }

  // Get selected vehicle object
  Vehicle? getSelectedVehicle() {
    if (_selectedVehicleId == null) return null;
    return _vehicles.firstWhere(
      (vehicle) => vehicle.id == _selectedVehicleId,
    );
  }

  // Clear selection
  void clearSelection() {
    _selectedVehicleId = null;
    notifyListeners();
  }

  // Load vehicles from API
  Future<void> loadVehicles() async {
    try {
      // TODO: Replace with actual API call
      // final response = await vehicleRepository.fetchVehicles();
      // _vehicles.clear();
      // _vehicles.addAll(response);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading vehicles: $e');
      rethrow;
    }
  }

  // Add new vehicle
  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      // TODO: Replace with actual API call
      _vehicles.add(vehicle);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding vehicle: $e');
      rethrow;
    }
  }

  // Remove vehicle
  Future<void> removeVehicle(String vehicleId) async {
    try {
      // TODO: Replace with actual API call
      _vehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
      if (_selectedVehicleId == vehicleId) {
        _selectedVehicleId = null;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error removing vehicle: $e');
      rethrow;
    }
  }
}
