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
          bottom: TSizes.spaceBtwSections), // Adjust spacing between cards
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Profile
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color:
                      Colors.grey[200], // Placeholder color for missing image
                  child: Image.asset(
                    doctorImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),

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
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        Text(
                          distance,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Rating and Open Time
                    Row(
                      children: [
                        // Rating Section
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '$rating',
                              style: const TextStyle(
                                fontSize: TSizes.fontSizeSm,
                                color: TColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        // Open Time
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            Text(
                              '$reviewsCount Reviews',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
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
          const SizedBox(height: 12),

          // Full-width Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side:
                      const BorderSide(color: TColors.transparent, width: 1.5),
                  backgroundColor: TColors.primary.withOpacity(0.2)),
              child: const Text(
                'Make Appointment',
                style: TextStyle(
                    fontSize: TSizes.fontSizeSm, color: TColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
