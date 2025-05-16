
class BookingModel {
  final String id;
  final String doctorName;
  final String specialization;
  final DateTime dateTime;
  final String patientName;
  final String status; // e.g., "Pending", "Confirmed", "Completed"

  BookingModel({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.dateTime,
    required this.patientName,
    this.status = 'Pending',
  });

  // Factory method to create an empty booking
  factory BookingModel.empty() {
    return BookingModel(
      id: '',
      doctorName: 'Unknown',
      specialization: 'Unknown',
      dateTime: DateTime.now(),
      patientName: 'Unknown',
      status: 'Pending',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'specialization': specialization,
      'dateTime': dateTime.toIso8601String(),
      'patientName': patientName,
      'status': status,
    };
  }

  // Create a BookingModel from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      doctorName: json['doctorName'] ?? 'Unknown',
      specialization: json['specialization'] ?? 'Unknown',
      dateTime: DateTime.parse(json['dateTime'] ?? DateTime.now().toIso8601String()),
      patientName: json['patientName'] ?? 'Unknown',
      status: json['status'] ?? 'Pending',
    );
  }
}
