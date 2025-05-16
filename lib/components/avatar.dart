import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final VoidCallback? onTap;

  const Avatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 60.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Allows tap functionality (e.g., edit profile)
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.blue.shade100,
        backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
            ? NetworkImage(imageUrl!) // Load profile image
            : null, // Show initials if no image
        child: imageUrl == null || imageUrl!.isEmpty
            ? Text(
                _getInitials(name),
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              )
            : null,
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = nameParts.map((e) => e[0]).take(2).join();
    return initials.toUpperCase();
  }
}
