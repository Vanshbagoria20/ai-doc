import 'package:flutter/material.dart';
import 'package:ai_doc/models/user.dart';

class ConsultingScreen extends StatelessWidget {
  final Function(String, {UserModel? user}) onNavigate;
final UserModel user;

  ConsultingScreen({super.key, required this.onNavigate, required this.user});

  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Sarah Wilson',
      'specialty': 'Cardiologist',
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=60&h=60',
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Dermatologist',
      'rating': '4.7',
      'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&q=80&w=60&h=60',
    },
    {
      'name': 'Dr. Emily Davis',
      'specialty': 'Neurologist',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?auto=format&fit=crop&q=80&w=60&h=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Consult a Doctor', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => onNavigate('dashboard', user: user),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return _buildDoctorCard(doctor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Doctor Card Widget
  Widget _buildDoctorCard(Map<String, String> doctor) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(doctor['image']!)),
        title: Text(doctor['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${doctor["specialty"]} • ⭐ ${doctor["rating"]}"),
        trailing: ElevatedButton(
          onPressed: () {
            // Function to start consultation
            onNavigate('consultation', user: user);
},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text('Consult Now'),
        ),
      ),
    );
  }
}
