enum BookingStatus { upcoming, completed, canceled }

class BookingModel {
  final String id;
  final DateTime date;
  final String locationName;
  final String address;
  final String connectorType;
  final int maxPower; // in kW
  final Duration duration;
  final double price;
  final BookingStatus status;
  
  BookingModel({
    required this.id,
    required this.date,
    required this.locationName,
    required this.address,
    required this.connectorType,
    required this.maxPower,
    required this.duration,
    required this.price,
    required this.status,
  });
  
  // Factory constructor for creating a Booking from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      date: DateTime.parse(json['date']),
      locationName: json['locationName'] ?? '',
      address: json['address'] ?? '',
      connectorType: json['connectorType'] ?? '',
      maxPower: json['maxPower'] ?? 0,
      duration: Duration(minutes: json['durationMinutes'] ?? 0),
      price: json['price']?.toDouble() ?? 0.0,
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
        orElse: () => BookingStatus.upcoming,
      ),
    );
  }
  
  // Method to convert Booking to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'locationName': locationName,
      'address': address,
      'connectorType': connectorType,
      'maxPower': maxPower,
      'durationMinutes': duration.inMinutes,
      'price': price,
      'status': status.toString().split('.').last,
    };
  }
  
  // Format date for display
  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
  
  // Format time for display
  String get formattedTime {
    final hour = date.hour;
    final minute = date.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
  
  // Format duration for display
  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}min';
    } else {
      return '${minutes}min';
    }
  }
}