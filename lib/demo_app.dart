import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> searchEVChargingStations(
    double latitude, double longitude, String apiKey) async {
  final radius = 5000; // Search within 5 km
  final type = 'electric_vehicle_charging_station';
  final url =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$type&key=$apiKey';

  try {
  final response = await http.get(Uri.parse(url));
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data['results'] as List<dynamic>;

    print("result: $results");
    // for (var station in results) {
    //   final name = station['name'];
    //   final lat = station['geometry']['location']['lat'];
    //   final lon = station['geometry']['location']['lng'];
    //   final address = station['vicinity'];
    //   print('Name: $name, Lat: $lat, Lon: $lon, Address: $address');
    // }
  } else {
    print('Error fetching data from Places API: ${response.statusCode}');
  }
} on Exception catch (e) {
  print("Exception: $e");
}
}

// Example usage:
void main() async {
  const apiKey = "AIzaSyA9M__GqBK-P8_vDqcAT7hCwwHS3dWtKzQ";
  final currentLat = 19.095445;
  final currentLon = 74.728974;

  await searchEVChargingStations(currentLat, currentLon, apiKey);
}


// Places API(new)

// Future<void> searchNearbyEVChargingStations(
//     double lat, double lng, String apiKey) async {
//   final url =
//       'https://places.googleapis.com/v1/places:searchNearby?key=$apiKey';

//   final headers = {'Content-Type': 'application/json'};

//   final body = jsonEncode({
//     'location': {
//       'latLng': {'latitude': lat, 'longitude': lng},
//     },
//     'radiusMeters': 5000,
//     'query': 'electric vehicle charging station',
//   });

//   final response = await http.post(
//     Uri.parse(url),
//     headers: headers,
//     body: body,
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     final results = data['results'] as List<dynamic>?;

//     if (results != null) {
//       for (var place in results) {
//         final name = place['name'];
//         final location = place['geometry']['location'];
//         final lat = location['lat'];
//         final lng = location['lng'];
//         print('Name: $name, Lat: $lat, Lng: $lng');
//       }
//     } else {
//       print('No results found.');
//     }
//   } else {
//     print('Request failed with status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }
// }

// // Example use:
// void main() async {
//   const apiKey = 'AIzaSyA9M__GqBK-P8_vDqcAT7hCwwHS3dWtKzQ';
//   const latitude = 19.095445;
//   const longitude = 74.728974;

//   await searchNearbyEVChargingStations(latitude, longitude, apiKey);
// }
