import 'package:denta_koas/src/commons/widgets/text/title_text.dart';
import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class PostCard extends StatelessWidget {
  final String name,
      image,
      university,
      title,
      description,
      category,
      timePosted,
      dateStart,
      dateEnd;
  final int requiredParticipant, participantCount, likesCount;
  final bool isNetworkImage;
  final void Function()? onPressed;
  final void Function()? onTap;

  const PostCard({
    super.key,
    required this.name,
    required this.image,
    required this.university,
    required this.title,
    required this.description,
    required this.category,
    required this.timePosted,
    required this.participantCount,
    required this.requiredParticipant,
    this.likesCount = 0,
    this.isNetworkImage = false,
    required this.dateStart,
    required this.dateEnd,
    this.onPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16), // Spasi antar card
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Pastikan ukuran mengikuti konten
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 24,
                      backgroundImage: isNetworkImage
                          ? NetworkImage(image)
                          : AssetImage(image) as ImageProvider),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TitleWithVerified(title: university)
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.heart,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () {
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
                                  Navigator.pop(context);
                                  // Handle edit action
                                },
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.close_circle),
                                title: const Text('Close'),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Handle close action
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Iconsax.trash,
                                  color: TColors.error,
                                ),
                                title: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: TColors.error,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        backgroundColor: TColors.white,
                                        title: Text(
                                          'Delete post from denta koas app ?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          'Post cannot be recovered once deleted. Are you sure you want to delete this post?',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          TSizes.cardRadiusSm),
                                                ),
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .apply(
                                                        color: TColors.error),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          TSizes.cardRadiusSm),
                                                ),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Upcoming Event Section
              Row(children: [
                Icon(
                  size: TSizes.iconXs,
                  FontAwesomeIcons.circleDot,
                  color: Colors.blue.shade400,
                ),
                const SizedBox(width: 4),
                Text(
                  'Posted $timePosted',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              TitleText(
                title: description,
                maxLines: 2,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.person_2,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$participantCount / $requiredParticipant',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Iconsax.category,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Iconsax.like,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$likesCount likes',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Button Section
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.calendar_1,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$dateStart - $dateEnd',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                          color: TColors.transparent, width: 1.5),
                      backgroundColor: TColors.primary,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Join',
                          style: TextStyle(
                              fontSize: TSizes.fontSizeMd,
                              color: TColors.white),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          CupertinoIcons.arrow_right_square,
                          size: TSizes.iconMd,
                          color: TColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
