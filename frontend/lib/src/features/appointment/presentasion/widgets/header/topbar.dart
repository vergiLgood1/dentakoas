import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // Gambar Avatar
          GestureDetector(
            onTap: () => Get.to(() => ()),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage:
                  AssetImage(TImages.user), // Ganti dengan asset gambar lokal
            ),
          ),
          const SizedBox(width: 12),
          // Teks Welcome
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: TSizes.fontSizeSm,
                  color: TColors.darkGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Andrew Smith',
                style: TextStyle(
                  fontSize: TSizes.fontSizeMd,
                  color: TColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
            FontAwesomeIcons.bell,
            color: TColors.textPrimary,
            size: 24,
            ),
          )
        ],
      ),
    );
  }
}
