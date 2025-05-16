import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save user to Firestore
  Future<void> saveUserToFirestore(UserModel user) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.id);

    try {
      await userRef.set(user.toMap());
      debugPrint('User saved to Firestore.');
    } catch (e) {
      debugPrint('Failed to save user: $e');
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        _currentUser = UserModel(
          id: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          profilePic: user.photoURL ?? '',
          role: 'user',
          isVerified: user.emailVerified,
        );
        _isAuthenticated = true;

        await saveUserToFirestore(_currentUser!);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _isAuthenticated = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Signup method
  Future<void> signup(String name, String email, String password, String phone) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.updatePhotoURL('https://example.com/profile.jpg');

        _currentUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phone: phone,
          profilePic: 'https://example.com/profile.jpg',
          role: 'user',
          isVerified: user.emailVerified,
        );
        _isAuthenticated = true;

        await saveUserToFirestore(_currentUser!);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _isAuthenticated = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Logout
  void logout() async {
    await _auth.signOut();
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}

  // Fetch user from Firestore
  Future<UserModel?> fetchUserFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Failed to fetch user: $e');
    }
    return null;
  }

