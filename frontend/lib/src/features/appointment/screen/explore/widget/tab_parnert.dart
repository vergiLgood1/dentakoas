import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/koas/all_koas.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TabParnert extends StatelessWidget {
  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Serenity Wellness Clinic',
      'major': 'Dental, Skin care',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
      'distance': '1.5km',
      'time': '15 min',
      'koasCount': 100,
      'imageUrl': 'https://via.placeholder.com/300x200', // Placeholder image
    },
    {
      'name': 'Radiant Health Family Clinic',
      'major': 'Dental, Skin care',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
      'distance': '1.5km',
      'time': '15 min',
      'koasCount': 100,
      'imageUrl': 'https://via.placeholder.com/300x200', // Placeholder image
    },
  ];

  TabParnert({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Partners showcase
              const CardShowcase(
                title: 'Our top partners',
                subtitle: 'Find the best partners in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const CardShowcase(
                title: 'Newest partners',
                subtitle: 'Find the newest partners in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Posts
              SectionHeading(
                  title: 'You might interest',
                  onPressed: () => Get.to(() => AllKoasScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              DGridLayout(
                itemCount: hospitals.length,
                crossAxisCount: 1,
                mainAxisExtent: 330,
                itemBuilder: (_, index) => UniversityCard(
                  image: hospitals[index]['imageUrl'],
                  title: hospitals[index]['name'],
                  subtitle: hospitals[index]['major'],
                  address: hospitals[index]['address'],
                  distance: hospitals[index]['distance'],
                  time: hospitals[index]['time'],
                  koasCount: hospitals[index]['koasCount'],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UniversityCard extends StatelessWidget {
  const UniversityCard({
    super.key,
    this.isNetworkImage = false,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.address,
    required this.distance,
    this.time = '0 min',
    this.koasCount = 0,
    this.int,
  });

  final String image, title, subtitle, address, distance, time;
  final int, koasCount;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: TColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusLg),
                  topRight: Radius.circular(TSizes.cardRadiusLg),
                ),
                child: isNetworkImage
                    ? Image.network(
                        image,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        TImages.promoBanner1,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.black54,
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.person_2_fill,
                          color: TColors.white, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        '$koasCount Koas',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Iconsax.location5,
                        size: 14, color: TColors.primary),
                    const SizedBox(width: 5),
                    Text(address),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Iconsax.clock5,
                        size: 14, color: TColors.primary),
                    const SizedBox(width: 5),
                    Text('$time • $distance'),
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
