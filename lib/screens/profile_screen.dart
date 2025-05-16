import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  final Function(String) onNavigate;

  ProfileScreen({super.key, required this.user, required this.onNavigate, required void Function() onLogout});

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.person,
      'title': 'Personal Information',
      'description': 'Update your personal details'
    },
    {
      'icon': Icons.lock,
      'title': 'Privacy & Security',
      'description': 'Manage your privacy settings'
    },
    {
      'icon': Icons.notifications,
      'title': 'Notifications',
      'description': 'Configure notification preferences'
    },
    {
      'icon': Icons.language,
      'title': 'Language',
      'description': 'Change your language'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => onNavigate('dashboard'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.profilePic),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(user.email, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text(user.phone, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Menu Items
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.blue),
                      title: Text(item['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(item['description'], style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      onTap: () {
                        // Handle menu item tap
                        switch (item['title']) {
                          case 'Personal Information':
                            onNavigate('personal_information');
                            break;
                          case 'Privacy & Security':
                            onNavigate('privacy_security');
                            break;
                          case 'Notifications':
                            onNavigate('notifications');
                            break;
                          case 'Language':
                            onNavigate('language');
                            break;
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
