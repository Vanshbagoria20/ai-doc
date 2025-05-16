import 'package:flutter/material.dart';

void main() {
  runApp(const AiDocApp());
}

class AiDocApp extends StatelessWidget {
  const AiDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ai_doc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/doc.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Welcome to ai_doc',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}