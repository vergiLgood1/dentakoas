import 'package:denta_koas/src/commons/widgets/cards/widget/post/footer.dart';
import 'package:denta_koas/src/commons/widgets/cards/widget/post/header.dart';
import 'package:denta_koas/src/commons/widgets/cards/widget/post/stat.dart';
import 'package:denta_koas/src/commons/widgets/cards/widget/post/title.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.only(bottom: 16),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(
                name: name,
                image: image,
                university: university,
                isNetworkImage: isNetworkImage,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TitleSection(
                  timePosted: timePosted,
                  title: title,
                  description: description),
              const SizedBox(height: TSizes.spaceBtwItems),
              StatsSection(
                participantCount: participantCount,
                requiredParticipant: requiredParticipant,
                category: category,
                likesCount: likesCount,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              FooterSection(dateStart: dateStart, dateEnd: dateEnd),
            ],
          ),
        ),
      ),
    );
  }
}

