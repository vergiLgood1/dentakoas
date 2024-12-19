import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/notifications/notification_menu.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DAppBar(
      avatar: Image.asset(
        TImages.user,
        fit: BoxFit.cover,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.black),
          ),
          Text(
            'Esther Howard',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.black),
          ),
        ],
      ),
      actions: [
        NotificationCounterIcon(onPressed: () {}),
      ],
    );
  }
}
