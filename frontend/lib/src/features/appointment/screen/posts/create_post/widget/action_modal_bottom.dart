import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/general.information/update_general_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ShowActionModal extends StatelessWidget {
  const ShowActionModal({
    super.key,
    this.post,
  });

  final Post? post;

  @override
  Widget build(BuildContext context) {
    final controller = PostController.instance;

    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                if (post!.status != 'Open')
                ListTile(
                  leading: const Icon(Icons.open_in_new),
                  title: const Text('Publish'),
                  onTap: () {
                      Navigator.of(Get.overlayContext!).pop();
                  },
                ),
                if (post!.status == 'Pending')
                  ListTile(
                    leading: const Icon(Iconsax.edit),
                    title: const Text('Edit'),
                    onTap: () {
                      Navigator.of(Get.overlayContext!).pop();
                      Get.to(
                        () => UpdateGeneralInformation(
                          postId: post!.id,
                        ),
                      );
                    },
                  ),
                if (post!.status != 'Open')
                ListTile(
                  leading: const Icon(Iconsax.trash, color: Colors.red),
                  title:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                  onTap: () {
                      Navigator.of(Get.overlayContext!).pop();
                      controller.confirmDeletePost(post!.id);
                    },
                  ),
                if (post!.status == 'Open')
                  ListTile(
                    leading:
                        const Icon(Iconsax.close_square, color: Colors.red),
                    title: const Text('Close',
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.of(Get.overlayContext!).pop();
                      // controller.confirmClosePost(post!.id);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
