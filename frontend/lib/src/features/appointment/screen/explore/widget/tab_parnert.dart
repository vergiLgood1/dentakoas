import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/university.controller/university_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/koas/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/parnert_post/post_with_specific_university.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TabParnert extends StatelessWidget {
 

  const TabParnert({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UniversityController());
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Partners showcase
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.popularUniversities.isEmpty) {
                  return const Center(child: Text('No data'));
                }
                final popularImages = controller.popularUniversities
                    .take(3)
                    .map((university) => university.image)
                    .where((image) => image != null)
                    .cast<String>()
                    .toList();

                return CardShowcase(
                  title: 'Our Top Partners',
                  subtitle: 'Find the best partners in your area',
                  images: popularImages,
                );
              }),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.featuredUniversities.isEmpty) {
                  return const Center(child: Text('No data'));
                }
                final newestImages = controller.newestUniversities
                    .take(3)
                    .map((university) => university.image)
                    .where((image) => image != null)
                    .cast<String>()
                    .toList();

                return CardShowcase(
                  title: 'Newest Universities',
                  subtitle: 'Check out the latest universities',
                  images: newestImages,
                );
              }),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Posts
              SectionHeading(
                  title: 'You might interest',
                  onPressed: () => Get.to(() => const AllUniversitiesScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.featuredUniversities.isEmpty) {
                    return const Center(child: Text('No data'));
                  }
                  return DGridLayout(
                    itemCount: 2,
                    crossAxisCount: 1,
                    mainAxisExtent: 330,
                    itemBuilder: (_, index) {
                      final university = controller.featuredUniversities[index];
                      return UniversityCard(
                        image: TImages.banner1,
                        title: university.name,
                        subtitle: university.alias,
                        address: university.location,
                        distance: '1.5km',
                        time: '15 min',
                        koasCount: university.koasCount,
                        onTap: () => Get.to(
                          () => const PostWithSpecificUniversity(),
                          arguments: university,
                        ),
                      );
                    },
                  );
                },
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
    this.onTap,
  });

  final String image, title, subtitle, address, distance, time;
  final int, koasCount;
  final bool isNetworkImage;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}
