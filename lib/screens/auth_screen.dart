import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_doc/models/user.dart';
import 'package:ai_doc/providers/auth_provider.dart' as local_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onLogin;

  const AuthScreen({super.key, required this.onLogin});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String role = 'patient';

  void handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<local_auth.AuthProvider>(context, listen: false);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    try {
      if (isLogin) {
        await authProvider.login(email, password);
      } else {
        await authProvider.signup(name, email, password, phone);
        await FirebaseFirestore.instance.collection('users').doc(authProvider.currentUser!.id).set({
          'id': authProvider.currentUser!.id,
          'name': name,
          'email': email,
          'phone': phone,
          'profilePic': authProvider.currentUser!.profilePic,
          'role': role,
          'isVerified': false,
        });
      }

      if (authProvider.isAuthenticated && authProvider.currentUser != null) {
        widget.onLogin(authProvider.currentUser!.toMap());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? 'Authentication failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLogin ? 'Welcome Back' : 'Create Account',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      if (!isLogin) ...[
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
                          validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
                          validator: (value) => value == null || value.isEmpty ? 'Enter phone number' : null,
                        ),
                      ],
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email)),
                        validator: (value) =>
                            value != null && value.contains('@') ? null : 'Enter a valid email',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                        validator: (value) =>
                            value != null && value.length >= 6 ? null : 'Password must be 6+ characters',
                      ),
                      if (!isLogin) ...[
                        const SizedBox(height: 16),
                        const Text('I am a:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceChip(
                              label: const Text('Patient'),
                              selected: role == 'patient',
                              onSelected: (_) => setState(() => role = 'patient'),
                            ),
                            const SizedBox(width: 10),
                            ChoiceChip(
                              label: const Text('Doctor'),
                              selected: role == 'doctor',
                              onSelected: (_) => setState(() => role = 'doctor'),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                      Consumer<local_auth.AuthProvider>(
                        builder: (_, authProvider, __) {
                          return authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: handleSubmit,
                                  child: Text(isLogin ? 'Login' : 'Sign Up'),
                                );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => setState(() => isLogin = !isLogin),
                        child: Text(isLogin
                            ? "Don't have an account? Sign Up"
                            : 'Already have an account? Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
