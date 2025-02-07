import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/cards/treatment_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/post_library_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/post_detail.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWithSpecificCategory extends StatelessWidget {
  const PostWithSpecificCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final treatment = Get.arguments;
    final controller = Get.put(PostController());

    return Scaffold(
      appBar: const DAppBar(
        title: Text('Category Post'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // 🔹 Treatment Card
            TreatmentCard(
              title: treatment.alias!,
              showVerifiyIcon: false,
              subtitle: treatment.name!,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // 🔹 Posts Section with Expanded
            Expanded(
              child: Obx(() {
                final filteredPosts = controller.posts
                    .where((post) => post.treatment.alias == treatment.alias)
                    .toList();

                if (controller.isLoading.value) {
                  return ShimmerCardPostUser(
                    itemCount:
                        filteredPosts.isNotEmpty ? filteredPosts.length : 3,
                  );
                }

                if (filteredPosts.isEmpty) {
                  return const StateScreen(
                    image: TImages.emptySearch2,
                    title: "Post not found",
                    subtitle: "Oppss. There is no post with this category",
                  );
                }

                return SortableField(
                  itemCount: filteredPosts.length,
                  crossAxisCount: 1,
                  mainAxisExtent: 400,
                  itemBuilder: (_, index) {
                    final post = filteredPosts[index];

                    return PostCard(
                      postId: post.id,
                      name: post.user.fullName,
                      image: TImages.userProfileImage2,
                      university:
                          post.user.koasProfile?.university ?? 'Unknown',
                      title: post.title,
                      description: post.desc,
                      category: post.treatment.alias,
                      timePosted: timeago.format(post.updateAt),
                      participantCount: post.totalCurrentParticipants,
                      requiredParticipant: post.requiredParticipant,
                      dateStart: post.schedule.isNotEmpty
                          ? DateFormat('dd').format(post.schedule[0].dateStart)
                          : 'N/A',
                      dateEnd: post.schedule.isNotEmpty
                          ? DateFormat('dd MMM yyyy')
                              .format(post.schedule[0].dateEnd)
                          : 'N/A',
                      likesCount: post.likeCount ?? 0,
                      onTap: () => Get.to(() => const PostDetailScreen(),
                          arguments: post),
                      onPressed: () => Get.to(() => const PostDetailScreen(),
                          arguments: post),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
