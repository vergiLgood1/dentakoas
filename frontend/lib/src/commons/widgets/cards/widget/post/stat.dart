import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StatsSection extends StatelessWidget {
  final int participantCount, requiredParticipant, likesCount;
  final String category;

  const StatsSection({
    super.key,
    required this.participantCount,
    required this.requiredParticipant,
    required this.category,
    required this.likesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          const Icon(CupertinoIcons.person_2, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$participantCount / $requiredParticipant',
              style: Theme.of(context).textTheme.bodyMedium),
        ]),
        Row(children: [
          const Icon(Iconsax.category, color: Colors.grey),
          const SizedBox(width: 8),
          Text(category, style: Theme.of(context).textTheme.bodyMedium),
        ]),
        Row(children: [
          const Icon(Iconsax.like, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$likesCount likes',
              style: Theme.of(context).textTheme.bodyMedium),
        ]),
      ],
    );
  }
}
