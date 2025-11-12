class Facility {
  final String id;
  final String name;
  final String description;
  final FacilityType type;
  final int capacity;
  final String location;
  final List<Booking> bookings;

  Facility({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.capacity,
    required this.location,
    this.bookings = const [],
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    var bookingsList = json['bookings'] as List? ?? [];
    List<Booking> bookings = bookingsList.map((b) => Booking.fromJson(b)).toList();

    return Facility(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: FacilityType.values.firstWhere(
        (e) => e.toString() == 'FacilityType.${json['type']}',
        orElse: () => FacilityType.auditorium,
      ),
      capacity: json['capacity'],
      location: json['location'],
      bookings: bookings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'capacity': capacity,
      'location': location,
      'bookings': bookings.map((b) => b.toJson()).toList(),
    };
  }
}

class Booking {
  final String id;
  final String facilityId;
  final String bookedBy; // Student ID
  final String bookedByName; // Student Name
  final DateTime bookingDate;
  final DateTime startTime;
  final DateTime endTime;
  final String purpose;
  final BookingStatus status;
  final String? approvedBy; // Authority ID
  final DateTime? approvedDate;

  Booking({
    required this.id,
    required this.facilityId,
    required this.bookedBy,
    required this.bookedByName,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
    required this.purpose,
    this.status = BookingStatus.pending,
    this.approvedBy,
    this.approvedDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      facilityId: json['facilityId'],
      bookedBy: json['bookedBy'],
      bookedByName: json['bookedByName'],
      bookingDate: DateTime.parse(json['bookingDate']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      purpose: json['purpose'],
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
        orElse: () => BookingStatus.pending,
      ),
      approvedBy: json['approvedBy'],
      approvedDate: json['approvedDate'] != null
          ? DateTime.parse(json['approvedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facilityId': facilityId,
      'bookedBy': bookedBy,
      'bookedByName': bookedByName,
      'bookingDate': bookingDate.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'purpose': purpose,
      'status': status.toString().split('.').last,
      'approvedBy': approvedBy,
      'approvedDate': approvedDate?.toIso8601String(),
    };
  }
}

enum FacilityType {
  auditorium,
  sports,
  classroom,
  laboratory,
  library,
}

enum BookingStatus {
  pending,
  approved,
  rejected,
  completed,
}