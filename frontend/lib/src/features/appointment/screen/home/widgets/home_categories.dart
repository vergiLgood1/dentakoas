import 'package:denta_koas/src/commons/widgets/image_text_widget/vertical_image_text.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return VerticalImageText(
            image: TImages.appleLogo,
            title: 'Apple Categories',
            textColor: TColors.textPrimary,
            onTap: () {},
            backgroundColor: TColors.primary.withOpacity(0.1),
          );
        },
      ),
    );
  }
}
