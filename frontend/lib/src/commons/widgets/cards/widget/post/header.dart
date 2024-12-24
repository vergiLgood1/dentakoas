import 'package:denta_koas/src/commons/controller/options.dart';
import 'package:denta_koas/src/commons/widgets/buttons/like_button.dart';
import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  final String name, image, university;
  final bool isNetworkImage;

  const HeaderSection({
    super.key,
    required this.name,
    required this.image,
    required this.university,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommonController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: isNetworkImage
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TitleWithVerified(title: university),
            ],
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return LikeButton();
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.grey),
          onPressed: () => controller.showOptions(context),
        ),
      ],
    );
  }
}
  
