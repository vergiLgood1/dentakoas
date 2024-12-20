import 'package:denta_koas/src/commons/widgets/image_text_widget/vertical_image_text.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final bool isScrollable = itemCount > 5;
    return SizedBox(
      height: 80,
      child: isScrollable
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: itemCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return VerticalImageText(
                  image: TImages.appleLogo,
                  title: 'Apple',
                  textColor: TColors.textPrimary,
                  onTap: () {},
                  backgroundColor:
                      TColors.primary.withAlpha((0.1 * 255).toInt()),
                );
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(itemCount, (index) {
                return VerticalImageText(
                  image: TImages.appleLogo,
                  title: 'Apple',
                  textColor: TColors.textPrimary,
                  onTap: () {},
                  backgroundColor:
                      TColors.primary.withAlpha((0.1 * 255).toInt()),
                );
              }),
            ),
    );
  }
}
