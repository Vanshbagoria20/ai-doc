class Appointment {
  String id;
  String doctorName;
  String specialty;
  DateTime dateTime;
  String status;
  String location;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.status,
    required this.location,
  });
}

Appointment newAppointment = Appointment(
  id: '1',
  doctorName: 'Dr. Sarah Wilson',
  specialty: 'Cardiologist',
  dateTime: DateTime.now().add(const Duration(days: 2)), // 2 days from now
  status: 'Pending',
  location: 'Online',
);
