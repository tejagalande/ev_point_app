
import 'dart:async';
import 'dart:developer';
import 'package:ev_point/controllers/home/station_list_provider.dart';
import 'package:ev_point/services/supabase_manager.dart';
import 'package:ev_point/utils/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StationMapProvider extends ChangeNotifier {
  // Lite mode for initial fast loading
  bool _liteModeEnable = true;
  bool get liteModeEnable => _liteModeEnable;

  bool _mapReady = false;
  bool get mapReady => _mapReady;

  // UI Features - start disabled for faster loading
  bool _myLocationEnabled = false;
  bool _myLocationButtonEnabled = false;
  bool _zoomControlsEnabled = false;
  bool _buildingsEnabled = false;
  bool _trafficEnabled = false;
  bool _indoorViewEnabled = false;
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;
  String? status;

  // Getters for UI features
  bool get myLocationEnabled => _myLocationEnabled;
  bool get myLocationButtonEnabled => _myLocationButtonEnabled;
  bool get zoomControlsEnabled => _zoomControlsEnabled;
  bool get buildingsEnabled => _buildingsEnabled;
  bool get trafficEnabled => _trafficEnabled;
  bool get indoorViewEnabled => _indoorViewEnabled;

  GoogleMapController? _controller;
  GoogleMapController? get controller => _controller;

  MarkerData? selectedMarker;

  Completer<GoogleMapController>? _completer;
  Completer<GoogleMapController>? get completer => _completer;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.4219999, -122.0862462),
    zoom: 10.0,
  );
  CameraPosition get initialPosition => _initialPosition;

  // Progressive loading timers
  Timer? _locationTimer;
  Timer? _featuresTimer;

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  List<MarkerData> _markerDataList = []; // Your marker data
  set markerDataList(List<MarkerData> list) {
    _markerDataList = list;
    notifyListeners();
  }

  bool _markersLoading = false;
  bool get markersLoading => _markersLoading;

  Timer? _markerLoadingTimer;
  int _currentMarkerIndex = 0;
  late RealtimeChannel stationStatusSubscriber ;
  StationListProvider stationListProvider;

  // Constructor here
  StationMapProvider({required this.stationListProvider}) {
    // initializeMarkers();
    stationListProvider.addListener(_onStationListChanged);
  }

  // --------------------------- functions start here ----------------------------------------
  void updateStationListProvider(StationListProvider newProvider) {
    stationListProvider.removeListener(_onStationListChanged);
    stationListProvider = newProvider;
    stationListProvider.addListener(_onStationListChanged);
    _onStationListChanged();
  }

  void _onStationListChanged() {
    if (!stationListProvider.isLoading &&
        stationListProvider.stationList != null) {
      initializeMarkers();
    }
  }

  // In your StationMapProvider constructor or initialization method
  void initializeMarkers() {
    // final customIcon = createLocalImageConfiguration(context, );
    // var stationMarkerList = stationListProvider!.stationList!.map((e) {
    //   var lat = e.location!.split(',')[0];
    //   var long = e.location!.split(',')[1];

    //   return MarkerData(
    //     id: e.id!.toString(),
    //     position: LatLng(double.parse(lat), double.parse(long)),
    //     title: "Station ${e.id}",
    //     snippet: e.name ?? "",
    //     icon: BitmapDescriptor.asset(ImageConfiguration(bundle: , assetName) ,
    //   );
    // },).toList();

    // _markerDataList = stationMarkerList;
    var listLen = stationListProvider.stationList?.length;
    // log("markers: $_markerDataList");
    log("markers length: $listLen");

    // _markerDataList = [
    //   MarkerData(
    //     id: 'station_1',
    //     position: LatLng(37.4219999, -122.0862462),
    //     title: 'Station 1',
    //     snippet: 'Fast charging available',
    //     icon: BitmapDescriptor.defaultMarker,
    //   ),
    //   MarkerData(
    //     id: 'station_2',
    //     position: LatLng(37.4319999, -122.0962462),
    //     title: 'Station 2',
    //     snippet: 'Level 2 charging',
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   ),
    //   // Add your other 3 markers...
    // ];
  }

  void loadMarkersProgressively() {
    if (_isDisposed || !_mapReady) return;

    _markersLoading = true;
    _currentMarkerIndex = 0;
    _markers.clear();
    notifyListeners();

    _loadNextMarker();
  }

  void _loadNextMarker() {
    if (_isDisposed || _currentMarkerIndex >= _markerDataList.length) {
      _markersLoading = false;
      notifyListeners();
      return;
    }

    // Add current marker
    final markerData = _markerDataList[_currentMarkerIndex];
    final marker = Marker(
      markerId: MarkerId(markerData.id),
      position: markerData.position,
      infoWindow: InfoWindow(
        title: markerData.title,
        snippet: markerData.snippet,
      ),
      // infoWindow: InfoWindow(),
      icon: markerData.icon,
      // onTap: () => _onMarkerTapped(markerData),
      onTap: () {
        selectedMarker = markerData;
        log("station id: ${markerData.id}");
        getStationStatus(markerData.id);

        notifyListeners();
        // log("selected marker: $selectedMarker");
      },
    );

    _markers.add(marker);
    _currentMarkerIndex++;
    notifyListeners();

    // Schedule next marker with delay
    _markerLoadingTimer = Timer(Duration(milliseconds: 300), () {
      if (!_isDisposed) _loadNextMarker();
    });
  }

  void getRealTimeStationStatus(String stationId) {
    try {
      stationStatusSubscriber = SupabaseManager.supabaseClient
          .channel('public:station')
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'station',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: int.parse(stationId),
            ),
            callback: (payload) {
              // log("new payload: ${payload.newRecord}");
              // log("old payload: ${payload.oldRecord}");
              // log("payload errors : ${payload.errors}");
              
              status = payload.newRecord['status'];
              log("station status: $status");
              notifyListeners();
            },
          );

      stationStatusSubscriber.subscribe();
    } on PostgrestException catch (postExc) {
      log("PostgreException: ${postExc.message}");
    } on Exception catch (e) {
      log("Exception: ${e}");
    }
  }

  void _onMarkerTapped(MarkerData markerData) {
    // Handle marker tap
    log('Marker tapped: ${markerData.title}');
  }

  void onMapCreated(GoogleMapController controller) async {
    log("onMapCreated(): ");
    if (_isDisposed) return;

    _controller = controller;
    _completer = Completer<GoogleMapController>();

    // Complete the completer only once
    if (!_completer!.isCompleted && _completer != null && !_isDisposed) {
      _completer!.complete(controller);
    }

    // Stage 1: Mark map as ready immediately
    _mapReady = true;
    log("map ready: $_mapReady");
    if (!_isDisposed) notifyListeners();

    // Stage 2: Start location process after short delay
    _locationTimer = Timer(Duration(milliseconds: 800), () {
      if (!_isDisposed) {
        log("called _handleLocationProcess func ");
        _handleLocationProcess();
      }
    });

    // Stage 3: Enable essential features
    _featuresTimer = Timer(Duration(milliseconds: 1200), () {
      if (!_isDisposed) {
        log("called _enableEssentialFeatures func ");
        _enableEssentialFeatures();
      }
    });
  }

  // Handle the complete location permission and fetching process
  Future<void> _handleLocationProcess() async {
    if (_isDisposed || !_mapReady || _controller == null) return;
    try {
      // Step 1: Check and request location permissions
      bool hasPermission = await _handleLocationPermission();

      if (hasPermission) {
        // Step 2: Get current location and animate camera
        await _getCurrentLocationAndAnimate();
      } else {
        log('Location permission denied');
        // Still enable some features even without location
        if (!_isDisposed) _enableEssentialFeatures();
      }
    } catch (e) {
      log('Location process error: $e');
      if (!_isDisposed) _enableEssentialFeatures();
    }
  }

  // Handle location permissions properly
  Future<bool> _handleLocationPermission() async {
    if (_isDisposed) return false;

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      return false;
    }

    // Check location permissions
    // permission = await Geolocator.checkPermission();

    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     log('Location permissions are denied');
    //     return false;
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   log('Location permissions are permanently denied');
    //   return false;
    // }

    var status = await PermissionManager.checkPermission(Permission.location);
    if (status == PermissionStatus.denied) {
      log("location permission denied");
      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      log("location permission permanently denied");
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocationAndAnimate() async {
    if (!_mapReady ||
        _controller == null ||
        _isDisposed ||
        _completer == null) {
      log('Map not ready or controller is null');
      return;
    }

    try {
      // Get current position with timeout
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.medium,
          forceLocationManager: false,
        ),
      ).timeout(Duration(seconds: 10));

      log('Location obtained: ${position.latitude}, ${position.longitude}');

      if (_isDisposed ||
          _controller == null ||
          _completer == null ||
          _completer!.isCompleted == false) {
        return;
      }

      await Future.delayed(Duration(milliseconds: 300));

      // Ensure controller is ready and animate camera
      try {
        final GoogleMapController controller = await _completer!.future;

        if (_isDisposed) return;

        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,
            ),
          ),
        );

        log('Camera animated to user location');

        // Enable location features after successful location and animation
        if (!_isDisposed) {
          _myLocationEnabled = true;
          notifyListeners();
        }
      } catch (e) {
        log("Camera animation error: $e");
      }
    } catch (e) {
      log('Location or animation error: $e');
      // Continue with default features
    }
  }

  void _enableEssentialFeatures() {
    if (_isDisposed) return;

    // Disable lite mode and enable essential features

    _liteModeEnable = false;
    _zoomControlsEnabled = true;
    _myLocationButtonEnabled = true;

    notifyListeners();

    // Enable secondary features after another delay
    // Timer(Duration(milliseconds: 500), () {
    //   if(_isDisposed) _enableSecondaryFeatures();
    // });
  }

  void _enableSecondaryFeatures() {
    if (_isDisposed) return;

    _buildingsEnabled = true;
    notifyListeners();
  }

  // Call this method when user interacts with map
  void onMapInteraction() {
    // log("onMapInteraction()");

    if (_isDisposed || !_mapReady) return;

    // log(
    //   "initial values: map ready=$_mapReady && lite mode enable=$_liteModeEnable",
    // );
    if (_liteModeEnable) {
      _liteModeEnable = false;
      _enableEssentialFeatures();
    }
  }

  // Manual location button press
  Future<void> moveToCurrentLocation() async {
    try {
      if (!_mapReady || _controller == null || _isDisposed) return;

      bool hasPermission = await _handleLocationPermission();
      if (_isDisposed || !hasPermission) return;

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          forceLocationManager: false,
        ),
      ).timeout(Duration(seconds: 10));

      if (_isDisposed || _controller == null) return;

      await Future.delayed(Duration(milliseconds: 300));
      if (_isDisposed) return;

      try {
        final GoogleMapController controller = await _completer!.future;

        if (_isDisposed) return;

        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 16.0,
            ),
          ),
        );

        if (!_isDisposed) {
          _myLocationEnabled = true;
          notifyListeners();
        }
      } catch (e) {
        log("Manual location animation error: $e");
      }
    } catch (e) {
      log('Manual location error: $e');
    }
  }

  // Enable all features for full functionality
  void enableAllFeatures() {
    if (_isDisposed) {
      return;
    }

    _liteModeEnable = false;
    _myLocationEnabled = true;
    _myLocationButtonEnabled = true;
    _zoomControlsEnabled = true;
    _buildingsEnabled = true;
    _trafficEnabled = false; // Keep disabled for performance
    _indoorViewEnabled = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    _featuresTimer?.cancel();
    _controller?.dispose();
    _controller = null;
    _completer = null;
    super.dispose();
  }
}

class MarkerData {
  final String id;
  final LatLng position;
  final String title;
  final String snippet;
  final BitmapDescriptor icon;

  MarkerData({
    required this.id,
    required this.position,
    required this.title,
    required this.snippet,
    required this.icon,
  });
}
