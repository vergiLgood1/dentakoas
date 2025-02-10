import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/cards/treatment_card.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // 🔹 Treatment Card
                    TreatmentCard(
                      title: treatment.alias!,
                      showVerifiyIcon: false,
                      subtitle: treatment.name!,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
              // 🔹 Posts Section
              Obx(() {
                final filteredPosts = controller.posts
                    .where((post) => post.treatment.alias == treatment.alias)
                    .toList();

                if (controller.isLoading.value) {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 400,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => const ShimmerPostCard(),
                      childCount: 3,
                    ),
                  );
                }

                if (filteredPosts.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const StateScreen(
                        image: TImages.emptySearch2,
                        title: "Post not found",
                        subtitle: "Oppss. There is no post with this category",
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = filteredPosts[index];
                      return PostCard(
                        postId: post.id,
                        name: post.user.fullName,
                        image: post.user.image ?? TImages.userProfileImage2,
                        university:
                            post.user.koasProfile?.university ?? 'Unknown',
                        title: post.title,
                        description: post.desc,
                        category: post.treatment.alias,
                        timePosted: timeago.format(post.updateAt),
                        participantCount: post.totalCurrentParticipants,
                        requiredParticipant: post.requiredParticipant,
                        dateStart: post.schedule.isNotEmpty
                            ? DateFormat('dd')
                                .format(post.schedule[0].dateStart)
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
                    childCount: filteredPosts.length,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
