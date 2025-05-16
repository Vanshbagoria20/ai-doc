import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class DashboardScreen extends StatelessWidget {
  final Function(String, {UserModel? user}) onNavigate;
  final Map<String, dynamic>? user;
  final VoidCallback onLogout;

  const DashboardScreen({
    super.key, 
    required this.onNavigate, 
    this.user, 
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User greeting
            if (user != null && user!['name'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Hello, ${user!['name']}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Quick Action Buttons
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3,
                children: [
                  _buildQuickActionButton(
                    'Appointments', 
                    Icons.calendar_today, 
                    Colors.blue, 
                    () => onNavigate('booking', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                  _buildQuickActionButton(
                    'Doctors', 
                    Icons.person, 
                    Colors.green, 
                    () => onNavigate('consulting', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                  _buildQuickActionButton(
                    'Consulting', 
                    Icons.local_hospital, 
                    Colors.purple, 
                    () => onNavigate('consulting', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                  _buildQuickActionButton(
                    'Messages', 
                    Icons.message, 
                    Colors.orange, 
                    () => onNavigate('messages', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                  _buildQuickActionButton(
                    'Profile', 
                    Icons.person, 
                    Colors.teal, 
                    () => onNavigate('profile', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Recent Messages Section
            const Text('Recent Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  _buildRecentMessageCard(
                    'Dr. Sarah Wilson',
                    'Your test results look good. Keep monitoring your blood pressure.',
                    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=60&h=60',
                    onTap: () => onNavigate('messages', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                  _buildRecentMessageCard(
                    'Dr. Michael Chen',
                    'Please send me photos of the affected area for review.',
                    'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&q=80&w=60&h=60',
                    onTap: () => onNavigate('messages', user: user != null ? UserModel.fromMap(user!) : null),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Action Button
  Widget _buildQuickActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha((0.1 * 255).toInt()),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Recent Message Card
  Widget _buildRecentMessageCard(String name, String message, String imageUrl, {VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}