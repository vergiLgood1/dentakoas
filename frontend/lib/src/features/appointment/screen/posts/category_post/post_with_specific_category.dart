import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PostWithSpecificCategory extends StatelessWidget {
  const PostWithSpecificCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('Category Post'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              const CategoryCard(
                title: 'Category 1',
                showVerifiyIcon: false,
                subtitle: 'Category 1 subtitle',
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SortableField(
                itemCount: 10,
                crossAxisCount: 1,
                itemBuilder: (_, index) => const CategoryCard(
                  title: 'Category 1',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
