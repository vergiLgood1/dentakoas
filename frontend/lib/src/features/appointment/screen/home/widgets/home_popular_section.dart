import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/categories/home_categories.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomePopularCategoriesSection extends StatelessWidget {
  const HomePopularCategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Heading
          SectionHeading(
            title: 'Popular Categories',
            showActionButton: false,
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          HomeCategories()
        ],
      ),
    );
  }
}
