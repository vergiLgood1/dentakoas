import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const DAppBar(
        title: Text('All Koas'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SortableField(
            itemCount: 10,
            crossAxisCount: 1,
            mainAxisExtent: 330,
            itemBuilder: (_, index) => const PostCard(
              name: 'Dr. John Doe',
              university: 'Politeknik Negeri Jember',
              image: TImages.userProfileImage4,
              timePosted: '2 hours ago',
              title: 'Open Relawan Pasien Koas',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              category: 'Pros',
              participantCount: 2,
              requiredParticipant: 5,
              dateStart: '01 Jan',
              dateEnd: '31 Jan 2024',
              likesCount: 20,
            ),
          ),
        ),
      ),
    );
  }
}
