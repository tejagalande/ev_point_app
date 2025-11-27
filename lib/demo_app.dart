import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider('AIzaSyA9M__GqBK-P8_vDqcAT7hCwwHS3dWtKzQ'),
      child: MaterialApp(
        title: 'Places Search',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PlacesSearchScreen(),
      ),
    );
  }
}



class PlacesSearchScreen extends StatefulWidget {
  @override
  _PlacesSearchScreenState createState() => _PlacesSearchScreenState();
}

class _PlacesSearchScreenState extends State<PlacesSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final provider = context.read<PlacesProvider>();
    provider.searchPlaces(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Places'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          context.read<PlacesProvider>().clearPredictions();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<PlacesProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (provider.predictions.isEmpty) {
                  return Center(
                    child: Text('No results found'),
                  );
                }

                return ListView.builder(
                  itemCount: provider.predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = provider.predictions[index];
                    return ListTile(
                      leading: Icon(Icons.location_on, color: Colors.blue),
                      title: Text(
                        prediction.primaryText,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(prediction.secondaryText ?? ''),
                      onTap: () async {
                        _controller.text = prediction.fullText;
                        _focusNode.unfocus();
                        
                        // Fetch detailed place information
                        await provider.fetchPlaceDetails(prediction.placeId);
                        
                        // Show details or navigate
                        _showPlaceDetails(provider.selectedPlace);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPlaceDetails(Place? place) {
    if (place == null) return;

  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name ?? 'Unknown',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Address: ${place.address ?? "N/A"}'),
          if (place.latLng != null)  // Changed from location to latLng
            Text(
              'Location: ${place.latLng!.lat}, ${place.latLng!.lng}',
            ),
          if (place.rating != null)
            Text('Rating: ${place.rating} ⭐'),
          if (place.userRatingsTotal != null)
            Text('Total Ratings: ${place.userRatingsTotal}'),
          if (place.phoneNumber != null)
            Text('Phone: ${place.phoneNumber}'),
          if (place.websiteUri != null)
            Text('Website: ${place.websiteUri}'),
        ],
      ),
    ),
  );
  }
}



class PlacesProvider extends ChangeNotifier {
  late FlutterGooglePlacesSdk _places;
  List<AutocompletePrediction> predictions = [];
  bool isLoading = false;
  Place? selectedPlace;

  PlacesProvider(String apiKey) {
    _places = FlutterGooglePlacesSdk(apiKey);
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
        countries: ['IN'], // Optional: restrict to countries
        // Optional: location bias
        // locationBias: LocationBias.circle(
        //   center: LatLng(28.6139, 77.2090),
        //   radius: 50000,
        // ),
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

  Future<void> fetchPlaceDetails(String placeId) async {
    try {
      final result = await _places.fetchPlace(
        placeId,
        fields: [
          PlaceField.Id,
          PlaceField.Name,
          PlaceField.Address,
          PlaceField.Location,
          PlaceField.Rating,
          PlaceField.UserRatingsTotal,
          PlaceField.PhoneNumber,
          PlaceField.WebsiteUri,
        ],
      );

      selectedPlace = result.place;
      notifyListeners();
    } catch (e) {
      print('Error fetching place details: $e');
    }
  }

  void clearPredictions() {
    predictions = [];
    notifyListeners();
  }
}
