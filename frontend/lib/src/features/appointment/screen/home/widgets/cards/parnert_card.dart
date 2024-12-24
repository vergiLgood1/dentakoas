import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? image; // Parameter untuk gambar avatar

  const ReusableCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Center(
            // Wrap the Row with Center
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar / Leading Widget
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.purple[100], // Latar belakang ungu muda
                    shape: BoxShape.circle,
                    image: image != null
                        ? DecorationImage(
                            image: NetworkImage(image!), // Gambar dari URL
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: image == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.purple,
                          size: 28.0,
                        )
                      : null,
                ),
                const SizedBox(width: 12), // Jarak antara avatar dan teks
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
