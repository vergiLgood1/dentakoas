import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostBadges extends StatelessWidget {
  const PostBadges({
    super.key,
    required this.category,
    required this.requiredParticipants,
    this.currentParticipants = 0,
    this.likesCount = 0,
  });

  final String category;
  final int requiredParticipants, currentParticipants, likesCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          const Icon(CupertinoIcons.person_2, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$currentParticipants / $requiredParticipants',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ]),
        Row(children: [
          const Icon(Iconsax.category, color: Colors.grey),
          const SizedBox(width: 8),
          Text(category, style: Theme.of(context).textTheme.bodyMedium),
        ]),
        Row(children: [
          const Icon(Iconsax.like, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$likesCount likes',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ]),
      ],
    );
  }
}
