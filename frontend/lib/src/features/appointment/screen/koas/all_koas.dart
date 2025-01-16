import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/university.controller/university_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/explore/widget/tab_parnert.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/parnert_post/post_with_specific_university.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUniversitiesScreen extends StatelessWidget {

  const AllUniversitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UniversityController());
    return Scaffold(
      appBar: const DAppBar(
        title: Text('University'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Categories
              DGridLayout(
                itemCount: controller.universities.length,
                crossAxisCount: 1,
                mainAxisExtent: 330,
                itemBuilder: (_, index) {
                  final university = controller.featuredUniversities[index];
                  return UniversityCard(
                    title: university.name,
                    subtitle: university.alias,
                    address: university.location,
                    distance: '1.5km',
                    time: '15 min',
                    koasCount: university.koasCount,
                    image: university.image ?? '',
                    onTap: () => Get.to(
                      () => const PostWithSpecificUniversity(),
                      arguments: university,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
