import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  // Add a new appointment
  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  // Remove an appointment
  void removeAppointment(String id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  // Update an appointment status
  void updateAppointmentStatus(String id, String newStatus) {
    int index = _appointments.indexWhere((appointment) => appointment.id == id);
    if (index != -1) {
      _appointments[index] = Appointment(
        id: _appointments[index].id,
        doctorName: _appointments[index].doctorName,
        specialty: _appointments[index].specialty,
        dateTime: _appointments[index].dateTime,
        status: newStatus,
        location: _appointments[index].location,
      );
      notifyListeners();
    }
  }

  // Load appointments from database (if needed)
  void setAppointments(List<Appointment> newAppointments) {
    _appointments = newAppointments;
    notifyListeners();
  }
}
