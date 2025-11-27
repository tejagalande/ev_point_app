import 'dart:async';
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
  bool isNavigating = false;
  bool hasArrived = false;
  String distance = "";
  String duration = "";
  StreamSubscription<Position>? _positionStreamSubscription;
  Timer? _refreshTimer;

  LatLng? _startLocation;
  LatLng? _endLocation;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> loadRoute(
    places_sdk.LatLng source,
    places_sdk.LatLng destination,
  ) async {
    isLoading = true;
    hasArrived = false;
    notifyListeners();

    // Convert to Google Maps LatLng
    _startLocation = LatLng(source.lat, source.lng);
    _endLocation = LatLng(destination.lat, destination.lng);

    // Add Markers
    markers.add(
      Marker(
        markerId: MarkerId("start"),
        position: _startLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "Start"),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("end"),
        position: _endLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "End"),
      ),
    );

    // Get Directions
    await _getDirections(_startLocation!, _endLocation!);

    isLoading = false;
    notifyListeners();

    // Fit bounds
    Future.delayed(Duration(milliseconds: 500), () {
      if (_startLocation != null && _endLocation != null) {
        _fitBounds(_startLocation!, _endLocation!);
      }
    });
  }

  Future<void> _getDirections(
    LatLng start,
    LatLng end, {
    bool silent = false,
  }) async {
    // Request alternatives to find the best/shortest route
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&alternatives=true&key=$_apiKey';

    try {
      if (!silent) log("RouteMapProvider: Fetching directions from: $url");
      final response = await http.get(Uri.parse(url));
      if (!silent) {
        log("RouteMapProvider: Response status: ${response.statusCode}");
        log("RouteMapProvider: Response body: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          if (!silent)
            log(
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

          // If silent update (navigation), notify listeners to update text
          if (silent) notifyListeners();

          // Use flutter_polyline_points to decode
          List<PointLatLng> result = PolylinePoints.decodePolyline(
            overviewPolyline,
          );
          List<LatLng> polylineCoordinates =
              result
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList();

          if (!silent)
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
              consumeTapEvents: true,
              width: 10,
              jointType: JointType.round,
            ),
          );
          polylines = newPolylines;
          if (silent) notifyListeners();
        } else {
          if (!silent) log("RouteMapProvider: No routes found in response");
        }
      } else {
        if (!silent)
          log("RouteMapProvider: API Error - ${response.reasonPhrase}");
      }
    } catch (e) {
      if (!silent) log("RouteMapProvider: Error fetching directions: $e");
    }
  }

  Future<void> startNavigation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      isNavigating = true;
      hasArrived = false;
      notifyListeners();

      // Start listening to location updates
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen((Position position) {
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18,
                tilt: 50,
                bearing: position.heading,
              ),
            ),
          );

          // Update Current Location Marker
          markers.removeWhere((m) => m.markerId.value == "current_location");
          markers.add(
            Marker(
              markerId: MarkerId("current_location"),
              position: LatLng(position.latitude, position.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
              rotation: position.heading,
              flat: true,
              anchor: Offset(0.5, 0.5),
              zIndex: 2,
            ),
          );

          // Check for Arrival
          if (_endLocation != null) {
            double distanceInMeters = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              _endLocation!.latitude,
              _endLocation!.longitude,
            );

            if (distanceInMeters < 10) {
              hasArrived = true;
              stopNavigation(); // This will cancel stream and timer
              return;
            }
          }

          // Real-time Polyline Update: Snap start to current location
          if (polylines.isNotEmpty) {
            try {
              final routePolyline = polylines.firstWhere(
                (p) => p.polylineId.value == "shortest_route",
                orElse: () => polylines.first,
              );
              List<LatLng> points = routePolyline.points;

              if (points.isNotEmpty) {
                // Find closest point index in the first 20 points (optimization)
                int closestIndex = 0;
                double minDistance = double.infinity;
                int searchLimit = points.length < 20 ? points.length : 20;

                for (int i = 0; i < searchLimit; i++) {
                  double dist = Geolocator.distanceBetween(
                    position.latitude,
                    position.longitude,
                    points[i].latitude,
                    points[i].longitude,
                  );
                  if (dist < minDistance) {
                    minDistance = dist;
                    closestIndex = i;
                  }
                }

                // Create new points list: [CurrentPos, ...points from closestIndex]
                // This prevents cutting corners by keeping the closest point
                List<LatLng> newPoints = [
                  LatLng(position.latitude, position.longitude),
                ];
                if (closestIndex < points.length) {
                  newPoints.addAll(points.sublist(closestIndex));
                }

                // Update polyline
                Set<Polyline> newPolylines = {};
                newPolylines.add(
                  Polyline(
                    polylineId: routePolyline.polylineId,
                    points: newPoints,
                    color: routePolyline.color,
                    width: routePolyline.width,
                    jointType: routePolyline.jointType,
                    consumeTapEvents: routePolyline.consumeTapEvents,
                  ),
                );
                polylines = newPolylines;
                notifyListeners();
              }
            } catch (e) {
              log("Error updating local polyline: $e");
            }
          }
        }
      });

      // Start periodic route updates
      _refreshTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        if (!isNavigating || _endLocation == null) {
          timer.cancel();
          return;
        }

        try {
          Position currentPos = await Geolocator.getCurrentPosition();
          LatLng start = LatLng(currentPos.latitude, currentPos.longitude);
          await _getDirections(start, _endLocation!, silent: true);
        } catch (e) {
          log("Error updating route: $e");
        }
      });
    } catch (e) {
      log("Error starting navigation: $e");
      isNavigating = false;
      notifyListeners();
    }
  }

  void stopNavigation() {
    _positionStreamSubscription?.cancel();
    _refreshTimer?.cancel();
    isNavigating = false;
    notifyListeners();

    // Reset camera to show the full route
    if (_startLocation != null && _endLocation != null) {
      _fitBounds(_startLocation!, _endLocation!);
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
      log("Error getting current location: $e");
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
