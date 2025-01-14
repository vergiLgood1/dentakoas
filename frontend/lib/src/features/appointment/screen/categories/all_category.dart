import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/treatment_card.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/treatment_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/category_post/post_with_specific_category.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TreatmentController());
    return Scaffold(
      appBar: const DAppBar(
        title: Text('All Categories'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: TSizes.spaceBtwItems),

              // Categories
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.treatments.isEmpty) {
                    return const Center(child: Text('No data'));
                  }
                  return DGridLayout(
                    itemCount: controller.treatments.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final treatment = controller.featuredTreatments[index];
                      return TreatmentCard(
                        title: treatment.alias!,
                        showBorder: true,
                        showVerifiyIcon: false,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        maxLines: 2,
                        onTap: () => Get.to(
                          () => const PostWithSpecificCategory(),
                          arguments: treatment,
                        ),
                      );
                    },
                  );
                }, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
