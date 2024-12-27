import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllKoasScreen extends StatelessWidget {
  const AllKoasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: const Text('All Koas'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SortableField(
            showDropdownMenu: false,
            itemCount: 10,
            crossAxisCount: 1,
            mainAxisExtent: 200,
            itemBuilder: (_, index) => const KoasCard(
              doctorName: 'Dr. John Doe',
              specialty: 'Dentist',
              distance: '2 km',
              rating: 4.5,
              reviewsCount: 120,
              openTime: '9:00 AM - 5:00 PM',
              doctorImageUrl: TImages.userProfileImage4,
            ),
          ),
        ),
      ),
    );
  }
}
