import 'package:denta_koas/src/commons/widgets/images/circular_image.dart';
import 'package:denta_koas/src/features/personalization/screen/profile/profile.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircularImage(
        image: TImages.user,
        width: 50,
        height: 50,
      
      ),
      title: Text(
        'Denta App',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.textWhite),
      ),
      subtitle: Text(
        'support@dentaapp.com',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: TColors.textWhite),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Iconsax.edit),
        color: TColors.white,
      ),
    );
  }
}
