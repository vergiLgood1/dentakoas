import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PartnerPosts extends StatelessWidget {
  const PartnerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('Parnert Post'),
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
                title: 'Politeknik Negeri Jember',
                subtitle: '200+ Availabel Koas',
                showVerifiyIcon: true,
                image: TImages.appleLogo,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SortableField(
                itemCount: 10,
                crossAxisCount: 1,
                mainAxisExtent: 80,
                itemBuilder: (_, index) => const CategoryCard(
                  title: 'Politeknik Negeri Jember',
                  showVerifiyIcon: false,
                  subtitle: '200+ Availabel Koas',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
