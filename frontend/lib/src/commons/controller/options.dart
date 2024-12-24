import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CommonController extends GetxController {
  static CommonController get instance => Get.find<CommonController>();

  void showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      backgroundColor: TColors.white,
      radius: 16,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Get.back();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: TColors.white,
          title: Text(
            'Delete post from denta koas app ?',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Post cannot be recovered once deleted. Are you sure you want to delete this post?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Handle delete action
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  overlayColor: TColors.darkGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: TColors.error),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  overlayColor: TColors.darkGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Iconsax.edit),
              title: const Text('Edit'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.close_circle),
              title: const Text('Close'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.trash, color: TColors.error),
              title:
                  const Text('Delete', style: TextStyle(color: TColors.error)),
              onTap: () {
                Get.back();
                showDeleteDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  void likeButton() {
    var isLiked = false.obs;

    void toggleLike() {
      isLiked.value = !isLiked.value;
    }

    Obx(
      () => IconButton(
        icon: Icon(
          Iconsax.heart,
          color: isLiked.value ? TColors.error : TColors.grey,
        ),
        onPressed: toggleLike,
      ),
    );
  }
  
 
}

