import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: const Row(
        children: [
          // Gambar Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage:
                AssetImage(TImages.user), // Ganti dengan asset gambar lokal
          ),
          SizedBox(width: 12),
          // Teks Welcome
          Column(
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
          Spacer(),
          // Ikon Hati
          FaIcon(
            FontAwesomeIcons.bell,
            color: TColors.textPrimary,
            size: 24,
          ),
        ],
      ),
    );
  }
}
