import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/partner_posts.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllParnertScreen extends StatelessWidget {
  const AllParnertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('Parnerts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Categories
              SortableField(
                showDropdownMenu: false,
                itemCount: 4,
                mainAxisExtent: 80,
                crossAxisCount: 1,
                itemBuilder: (_, index) => CategoryCard(
                  title: 'Politeknik Negeri Jember',
                  subtitle: '200+ Availabel Koas',
                  showVerifiyIcon: true,
                  image: TImages.appleLogo,
                  onTap: () => Get.to(() => const PartnerPosts()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
