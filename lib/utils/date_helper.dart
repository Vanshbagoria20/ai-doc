import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_doc/screens/dashboard_screen.dart';
import 'package:ai_doc/providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onLogin;

  const AuthScreen({super.key, required this.onLogin});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String role = 'patient';

  void handleSubmit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (isLogin) {
      await authProvider.login(emailController.text, passwordController.text);
    } else {
      await authProvider.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
        phoneController.text,
        // role, // Pass role
      );
    }

    if (authProvider.isAuthenticated) {
      widget.onLogin(authProvider.currentUser!.toMap());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            user: authProvider.currentUser!.toMap(),
            onNavigate: (screen, {user}) {}, onLogout: () {  },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage ?? 'An error occurred')),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? 'Welcome Back' : 'Create Account',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (!isLogin)
                      Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                    ),
                    if (!isLogin)
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          const Text('I am a:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                label: const Text('Patient'),
                                selected: role == 'patient',
                                onSelected: (selected) {
                                  setState(() => role = 'patient');
                                },
                              ),
                              const SizedBox(width: 10),
                              ChoiceChip(
                                label: const Text('Doctor'),
                                selected: role == 'doctor',
                                onSelected: (selected) {
                                  setState(() => role = 'doctor');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return authProvider.isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                key: const Key('loginButton'),
                                onPressed: handleSubmit,
                                child: Text(isLogin ? 'Login' : 'Sign Up'),
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(isLogin ? "Don't have an account? Sign Up" : 'Already have an account? Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
