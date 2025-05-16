class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profilePic;
  final String role; // patient, doctor, admin
  final bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePic,
    required this.role,
    required this.isVerified,
  });

  // Convert UserModel to Map (For Firebase or Local Storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profilePic': profilePic,
      'role': role,
      'isVerified': isVerified,
    };
  }

  // Create UserModel from Map (For retrieving data)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profilePic: map['profilePic'],
      role: map['role'],
      isVerified: map['isVerified'],
    );
  }

  static UserModel defaultUser() {
    return UserModel(
      id: 'default_id',
      name: 'Guest User',
      email: 'guest@example.com',
      phone: '0000000000',
      profilePic: 'https://www.gravatar.com/avatar/default?d=identicon',
      role: 'guest',
      isVerified: false,
    );
  }
}
