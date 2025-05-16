import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class NotificationsScreen extends StatelessWidget {
  final Function(String, {UserModel? user}) onNavigate;
  final UserModel user;

  NotificationsScreen({super.key, required this.onNavigate, required this.user});

  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'Appointment Reminder',
      'message': 'You have an appointment with Dr. Sarah Wilson tomorrow at 10:00 AM.',
      'time': '2 hours ago',
    },
    {
      'id': 2,
      'title': 'New Message',
      'message': 'Dr. Michael Chen has sent you a new message.',
      'time': '5 hours ago',
    },
    {
      'id': 3,
      'title': 'Prescription Ready',
      'message': 'Your prescription is ready for pickup at the pharmacy.',
      'time': '1 day ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => onNavigate('dashboard', user: user),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(notification['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notification['message']),
                trailing: Text(notification['time'], style: const TextStyle(color: Colors.grey)),
                onTap: () {
                  // Handle notification tap
                  // You can navigate to a specific screen based on the notification type
                },
              ),
            );
          },
        ),
      ),
    );
  }
}