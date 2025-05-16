import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user to Firestore
  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  // Get user from Firestore
  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot doc = await _db.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update user in Firestore
  Future<void> updateUser(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toMap());
  }

  // Delete user from Firestore
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }
}
