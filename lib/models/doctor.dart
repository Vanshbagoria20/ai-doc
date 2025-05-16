class Doctor {
final String id;
final String name;
final String specialty;
final String profilePic;
final double rating;
final String experience;
final String location; // Online or Clinic
final List<String> availableTimes; // List of available time slots

Doctor({
  required this.id,
  required this.name,
  required this.specialty,
  required this.profilePic,
  required this.rating,
  required this.experience,
  required this.location,
  required this.availableTimes,
});

Doctor newDoctor = Doctor(
  id: '1',
  name: 'Dr. Sarah Wilson',
  specialty: 'Cardiologist',
  profilePic: 'https://example.com/doctor.jpg',
  rating: 4.8,
  experience: '10 years',
  location: 'Online',
  availableTimes: ['10:00 AM', '2:00 PM', '4:30 PM'],
);


  // Convert Doctor to Map (For Firebase or Local Storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'profilePic': profilePic,
      'rating': rating,
      'experience': experience,
      'location': location,
      'availableTimes': availableTimes,
    };
  }

  // Create Doctor from Map (For retrieving data)
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      name: map['name'],
      specialty: map['specialty'],
      profilePic: map['profilePic'],
      rating: map['rating'].toDouble(),
      experience: map['experience'],
      location: map['location'],
      availableTimes: List<String>.from(map['availableTimes']),
    );
  }
}
