import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/action_modal_bottom.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPostUser extends StatelessWidget {
  const CardPostUser(
      {super.key,
      required this.title,
      required this.desc,
      required this.treatment,
      required this.status,
      required this.statusColor,
    required this.updatedAt,
    this.onTap,
    this.post,
  });

  final String title;
  final String desc;
  final String treatment;
  final String status;
  final Color statusColor;
  final DateTime updatedAt;
  final Function()? onTap;
  final Post? post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          side: const BorderSide(
            color: TColors.accent,
          ),
        ),
        color: TColors.grey.withOpacity(0.0),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
          child: Column(
            children: [
              // Section 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8.0,
                        color: statusColor,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems / 4),
                      Text(
                        status,
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                              color: statusColor,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          DateFormat('dd MMM yyyy').format(
                            updatedAt,
                          ),
                          style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: TColors.textSecondary,
                              )),
                      ShowActionModal(post: post!),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Section 2
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: TColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    Text(
                      desc,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: TColors.textSecondary,
                          ),
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Section 3
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Treatment: $treatment',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: TColors.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
