import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geolocator/geolocator.dart';

class RouteSearchProvider extends ChangeNotifier {
  final TextEditingController sourceController = TextEditingController(
    text: "Your Location",
  );
  final TextEditingController destinationController = TextEditingController();

  late FlutterGooglePlacesSdk _places;
  List<AutocompletePrediction> predictions = [];
  bool isLoading = false;
  bool isSourceFocused = false;

  LatLng? sourceLatLng;
  LatLng? destinationLatLng;
  String? sourceName;
  String? destinationName;

  // TODO: Replace with your actual Google Places API Key
  final String _apiKey = 'AIzaSyA9M__GqBK-P8_vDqcAT7hCwwHS3dWtKzQ';

  RouteSearchProvider() {
    _places = FlutterGooglePlacesSdk(_apiKey);
  }

  void swapLocations() {
    String tempText = sourceController.text;
    sourceController.text = destinationController.text;
    destinationController.text = tempText;

    LatLng? tempLatLng = sourceLatLng;
    sourceLatLng = destinationLatLng;
    destinationLatLng = tempLatLng;

    String? tempName = sourceName;
    sourceName = destinationName;
    destinationName = tempName;

    notifyListeners();
  }

  void setFocus(bool isSource) {
    isSourceFocused = isSource;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentPos = LatLng(
        lat: position.latitude,
        lng: position.longitude,
      );

      if (isSourceFocused) {
        sourceLatLng = currentPos;
        sourceName = "Your Location";
        sourceController.text = "Your Location";
      } else {
        destinationLatLng = currentPos;
        destinationName = "Your Location";
        destinationController.text = "Your Location";
      }
      notifyListeners();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void selectYourLocation() {
    getCurrentLocation();
  }

  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      predictions = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final result = await _places.findAutocompletePredictions(
        query,
        countries: ['IN'],
      );

      predictions = result.predictions;
    } catch (e) {
      print('Error fetching predictions: $e');
      predictions = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlaceDetails(String placeId, {bool isSource = true}) async {
    try {
      final result = await _places.fetchPlace(
        placeId,
        fields: [
          PlaceField.Id,
          PlaceField.Name,
          PlaceField.Address,
          PlaceField.Location,
        ],
      );

      final place = result.place;
      if (place != null && place.latLng != null) {
        if (isSource) {
          sourceLatLng = place.latLng;
          sourceName = place.name;
        } else {
          destinationLatLng = place.latLng;
          destinationName = place.name;
        }
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching place details: $e');
    }
  }

  void clearPredictions() {
    predictions = [];
    notifyListeners();
  }

  void selectPlace(AutocompletePrediction prediction) {
    if (isSourceFocused) {
      sourceController.text = prediction.fullText;
      fetchPlaceDetails(prediction.placeId, isSource: true);
    } else {
      destinationController.text = prediction.fullText;
      fetchPlaceDetails(prediction.placeId, isSource: false);
    }

    clearPredictions();
  }

  @override
  void dispose() {
    sourceController.dispose();
    destinationController.dispose();
    super.dispose();
  }
}
