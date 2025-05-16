import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Simulated Login
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simulate network request

    if (email == 'user@example.com' && password == 'password123') {
      _currentUser = UserModel(
        id: '1',
        name: 'John Doe',
        email: email,
        phone: '+1 555-123-4567',
        profilePic: 'https://example.com/profile.jpg',
        role: 'patient',
        isVerified: true,
      );
    } else {
      _errorMessage = 'Invalid email or password';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Simulated Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Update User Profile
  void updateUser(UserModel updatedUser) {
    _currentUser = updatedUser;
    notifyListeners();
  }
}
