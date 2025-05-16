import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class MessagesScreen extends StatelessWidget {
  final Function(String, {UserModel? user}) onNavigate;
  final UserModel user;

  MessagesScreen({super.key, required this.onNavigate, required this.user});

  final List<Map<String, dynamic>> conversations = [
    {
      'id': 1,
      'name': 'Dr. Sarah Wilson',
      'specialty': 'Cardiologist',
      'lastMessage': 'Your test results look good. Keep monitoring your blood pressure.',
      'time': '10:30 AM',
      'unread': 2,
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=60&h=60',
    },
    {
      'id': 2,
      'name': 'Dr. Michael Chen',
      'specialty': 'Dermatologist',
      'lastMessage': 'Please send me photos of the affected area for review.',
      'time': 'Yesterday',
      'unread': 0,
      'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&q=80&w=60&h=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Messages', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => onNavigate('dashboard', user: user),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search conversations',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Conversations List
            Expanded(
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  var conversation = conversations[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Doctor's Image
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(conversation['image']),
                          ),
                          const SizedBox(width: 12),

                          // Doctor's Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conversation['name'],
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(conversation['specialty'], style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text(
                                  conversation['lastMessage'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),

                          // Time & Unread Count
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(conversation['time'], style: const TextStyle(color: Colors.grey)),
                              if (conversation['unread'] > 0)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "${conversation['unread']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
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
