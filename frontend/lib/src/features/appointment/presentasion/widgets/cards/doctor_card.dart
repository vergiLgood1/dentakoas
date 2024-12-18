import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String distance;
  final double rating;
  final int reviewsCount;
  final String openTime;
  final String doctorImageUrl;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.distance,
    required this.rating,
    required this.reviewsCount,
    required this.openTime,
    required this.doctorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: TSizes.spaceBtwItems), // Add margin to create space between cards
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Profile
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(doctorImageUrl),
          ),
          const SizedBox(width: 12),

          // Doctor Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),

                // Specialty and Distance
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Rating and Open Time
                Row(
                  children: [
                    // Rating Section
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: TSizes.iconBase, color: TColors.secondary),
                        const SizedBox(width: 4),
                        Text(
                          '$rating ($reviewsCount Reviews)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: TColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Open Time
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: TSizes.iconBase, color: TColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Open at $openTime',
                          style: const TextStyle(
                            fontSize: 12,
                            color: TColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
