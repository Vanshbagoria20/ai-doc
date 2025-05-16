import 'package:flutter/material.dart';
import 'auth_screen.dart'; // Update with the correct path

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onGetStarted;

  const OnboardingScreen({super.key, required this.onGetStarted});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.medical_services,
      'title': 'Instant Doctor Access',
      'description': 'Connect with certified doctors anytime, anywhere.'
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'AI Health Insights',
      'description': 'Receive personalized health recommendations powered by AI.'
    },
    {
      'icon': Icons.verified,
      'title': 'Secure & Private',
      'description': 'HIPAA-compliant and encrypted to protect your data.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Hero Section
            Text(
              'Welcome to MedAi',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Your personal AI-powered healthcare companion.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Features Grid
            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // 1 item per row
                  childAspectRatio: 3, // Adjust aspect ratio
                ),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(feature['icon'], color: Colors.blue[600], size: 40),
                      title: Text(feature['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(feature['description']),
                    ),
                  );
                },
              ),
            ),

            // Get Started Button
            const SizedBox(height: 20),
            ElevatedButton.icon(
              key: const Key('getStartedButton'), // Assign key
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen(onLogin: (data) => widget.onGetStarted())),
                );
              },
              icon: const Icon(Icons.arrow_forward, size: 20),
              label: const Text('Get Started', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.blue[600],
              ),
            ),

            // Trust Indicators
            const SizedBox(height: 20),
            Text('Trusted by thousands of patients and doctors', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 5),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text('🔒 HIPAA Compliant', style: TextStyle(color: Colors.grey[700])),
                const Text(' • '),
                Text('🏥 Certified Providers', style: TextStyle(color: Colors.grey[700])),
                const Text(' • '),
                Text('🤖 AI-Powered', style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
