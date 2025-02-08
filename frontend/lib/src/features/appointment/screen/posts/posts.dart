import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/post_library_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/explore.controller/explore_post_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/post_detail.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExplorePostController());
    return Scaffold(
      appBar: const DAppBar(
        title: Text('All Koas'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return DGridLayout(
                  itemCount:
                      controller.posts.isNotEmpty ? controller.posts.length : 3,
                  mainAxisExtent: 240,
                  crossAxisCount: 1,
                  itemBuilder: (_, index) {
                    return const ShimmerPostCard();
                  },
                );
              }
              if (controller.posts.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const StateScreen(
                    image: TImages.emptySearch2,
                    title: "Post not found",
                    subtitle: "Oppss. There is no post found.",
                  ),
                );
              }
              return SortableField(
                crossAxisCount: 1,
                mainAxisExtent: 400,
                showSearchBar: true,
                itemBuilder: (_, index) {
                  final post = controller.posts[index];
                  return PostCard(
                    postId: post.id,
                    name: post.user.fullName,
                    image: TImages.userProfileImage2,
                    university: post.user.koasProfile!.university!,
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
                    onTap: () =>
                        Get.to(() => const PostDetailScreen(), arguments: post),
                    onPressed: () =>
                        Get.to(() => const PostDetailScreen(), arguments: post),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
