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
        color: TColors.textWhite,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Profile
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 100,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Doctor Name
                    Text(
                      doctorName,
                      style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: TColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),

                    // Specialty and Distance
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            specialty,
                            style:
                                Theme.of(context).textTheme.bodyMedium!.apply(
                                      color: TColors.textSecondary,
                                    ),
                          ),
                        ),
                        const Icon(Icons.location_on,
                            size: TSizes.iconSm, color: TColors.primary),
                        Text(
                          distance,
                          style: Theme.of(context).textTheme.labelMedium!.apply(
                                color: TColors.textSecondary,
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
                                size: TSizes.iconBase, color: Colors.orange),
                            const Icon(Icons.star,
                                size: TSizes.iconBase, color: Colors.orange),
                            const Icon(Icons.star,
                                size: TSizes.iconBase, color: Colors.orange),
                            const Icon(Icons.star,
                                size: TSizes.iconBase, color: Colors.orange),
                            const Icon(Icons.star,
                                size: TSizes.iconBase, color: Colors.orange),
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

                        // Divider
                        Container(
                          width: 2,
                          height: TSizes.iconBase,
                          color: TColors.grey.withAlpha((0.4 * 255).toInt()),
                        ),
                        const SizedBox(width: 8),

                        // Open Time
                        Text(
                          '$reviewsCount Reviews',
                          style: const TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            color: TColors.textSecondary,
                          ),
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
                  backgroundColor:
                      TColors.primary.withAlpha((0.2 * 255).toInt())),
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

