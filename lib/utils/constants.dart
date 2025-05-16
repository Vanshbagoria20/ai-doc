import 'package:flutter/material.dart';

class AppConstants {
  // 🔹 App Information
  static const String appName = 'MedAi';
  static const String appVersion = '1.0.0';

  // 🔹 API & Database
  static const String firebaseUsersCollection = 'users';
  static const String firebaseAppointmentsCollection = 'appointments';
  static const String firebaseMessagesCollection = 'messages';
  static const String firebaseNotificationsCollection = 'notifications';

  // 🔹 Default User Images
  static const String defaultProfilePic = 'https://example.com/default_profile.jpg';
  static const String doctorPlaceholderPic = 'https://example.com/default_doctor.jpg';

  // 🔹 Notification Topics
  static const String fcmTopicGeneral = 'general_notifications';
  static const String fcmTopicAppointments = 'appointment_updates';

  // 🔹 Colors (App Theme)
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF34C759);
  static const Color errorColor = Color(0xFFFF3B30);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // 🔹 Message Status
  static const String messageStatusSent = 'sent';
  static const String messageStatusDelivered = 'delivered';
  static const String messageStatusRead = 'read';

  // 🔹 Appointment Status
  static const String appointmentPending = 'Pending';
  static const String appointmentConfirmed = 'Confirmed';
  static const String appointmentCompleted = 'Completed';
  static const String appointmentCancelled = 'Cancelled';
}
