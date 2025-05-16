import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class BookingScreen extends StatelessWidget {
  final Function(String, {UserModel? user}) onNavigate;
  final UserModel user;

  const BookingScreen({super.key, required this.onNavigate, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book an Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => onNavigate('dashboard', user: user),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user.name}'),
            const SizedBox(height: 20),
            // Add more widgets here to display user information or booking details
            ElevatedButton(
              onPressed: () => onNavigate('profile', user: user),
              child: const Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () => onNavigate('consultation', user: user),
              child: const Text('Go to Consultation'),
            ),
            ElevatedButton(
              onPressed: () => onNavigate('messages', user: user),
              child: const Text('Go to Messages'),
            ),
            ElevatedButton(
              onPressed: () => onNavigate('settings', user: user),
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
