import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class AppointmentCards extends StatelessWidget {
  const AppointmentCards({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.category,
    required this.date,
    required this.timestamp,
  });

  final String imgUrl;
  final String name;
  final String category;
  final String date;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointments Today',
          style: TextStyle(
            fontSize: TSizes.fontSizeLg,
            fontWeight: FontWeight.bold,
            color: TColors.textPrimary,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF3D8BFF), // Warna latar biru
            borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar Dokter
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgUrl), // Background ungu muda
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ), // Jarak antara avatar dan teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Dokter
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: TSizes.fontSizeMd,
                            fontWeight: FontWeight.bold,
                            color: TColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Jabatan
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            color: TColors.textWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icon panah
                  const Icon(
                    FontAwesomeIcons.chevronRight,
                    color: TColors.textWhite,
                    size: TSizes.iconLg,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(
                color: TColors.textWhite,
                thickness: 0.5,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Baris Kalender & Waktu
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.calendar,
                        color: TColors.textWhite,
                        size: TSizes.iconSm,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: TSizes.fontSizeSm,
                          color: TColors.textWhite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.clock,
                        color: TColors.textWhite,
                        size: TSizes.iconSm,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timestamp,
                        style: const TextStyle(
                          fontSize: TSizes.fontSizeSm,
                          color: TColors.textWhite,
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
    );
  }
}
