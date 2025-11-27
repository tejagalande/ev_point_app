import 'dart:convert';
import 'dart:developer';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places_sdk;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteMapProvider extends ChangeNotifier {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  final String _apiKey = 'AIzaSyA9M__GqBK-P8_vDqcAT7hCwwHS3dWtKzQ';

  bool isLoading = true;
  String distance = "";
  String duration = "";

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> loadRoute(
    places_sdk.LatLng source,
    places_sdk.LatLng destination,
  ) async {
    isLoading = true;
    notifyListeners();

    // Convert to Google Maps LatLng
    LatLng start = LatLng(source.lat, source.lng);
    LatLng end = LatLng(destination.lat, destination.lng);

    // Add Markers
    markers.add(
      Marker(
        markerId: MarkerId("start"),
        position: start,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "Start"),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("end"),
        position: end,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "End"),
      ),
    );

    // Get Directions
    await _getDirections(start, end);

    isLoading = false;
    notifyListeners();

    // Fit bounds
    Future.delayed(Duration(milliseconds: 500), () {
      _fitBounds(start, end);
    });
  }

  Future<void> _getDirections(LatLng start, LatLng end) async {
    // Request alternatives to find the best/shortest route
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&alternatives=true&key=$_apiKey';

    try {
      print("RouteMapProvider: Fetching directions from: $url");
      final response = await http.get(Uri.parse(url));
      print("RouteMapProvider: Response status: ${response.statusCode}");
      print("RouteMapProvider: Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          print(
            "RouteMapProvider: Found ${(data['routes'] as List).length} routes",
          );

          // Find the shortest route based on distance
          var routes = data['routes'] as List;
          var shortestRoute = routes[0];
          int minDistance = shortestRoute['legs'][0]['distance']['value'];

          for (var route in routes) {
            int currentDistance = route['legs'][0]['distance']['value'];
            if (currentDistance < minDistance) {
              minDistance = currentDistance;
              shortestRoute = route;
            }
          }

          final overviewPolyline = shortestRoute['overview_polyline']['points'];
          final legs = shortestRoute['legs'][0];

          distance = legs['distance']['text'];
          duration = legs['duration']['text'];

          // Use flutter_polyline_points to decode
          PolylinePoints polylinePoints = PolylinePoints(apiKey: _apiKey);
          List<PointLatLng> result = PolylinePoints.decodePolyline(
            overviewPolyline,
          );
          List<LatLng> polylineCoordinates =
              result
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList();

          log(
            "RouteMapProvider: Decoded ${polylineCoordinates.length} points for polyline",
          );

          // Create a new Set to ensure UI update
          Set<Polyline> newPolylines = {};
          newPolylines.add(
            Polyline(
              polylineId: PolylineId("shortest_route"),
              points: polylineCoordinates,
              color: AppColor.primary_900,
              width: 10,
            ),
          );
          polylines = newPolylines;
        } else {
          print("RouteMapProvider: No routes found in response");
        }
      } else {
        print("RouteMapProvider: API Error - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("RouteMapProvider: Error fetching directions: $e");
    }
  }

  Future<void> animateToCurrentLocation() async {
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

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15,
            ),
          ),
        );
      }
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void _fitBounds(LatLng start, LatLng end) {
    if (mapController == null) return;

    LatLngBounds bounds;
    if (start.latitude > end.latitude && start.longitude > end.longitude) {
      bounds = LatLngBounds(southwest: end, northeast: start);
    } else if (start.longitude > end.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(start.latitude, end.longitude),
        northeast: LatLng(end.latitude, start.longitude),
      );
    } else if (start.latitude > end.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(end.latitude, start.longitude),
        northeast: LatLng(start.latitude, end.longitude),
      );
    } else {
      bounds = LatLngBounds(southwest: start, northeast: end);
    }

    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }
}
