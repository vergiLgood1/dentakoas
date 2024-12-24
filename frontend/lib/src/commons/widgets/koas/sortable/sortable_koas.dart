import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SortableField extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double? mainAxisExtent;
  final bool showDropdownMenu;

  const SortableField({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisExtent,
    this.showDropdownMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDropdownMenu)
          DropdownButtonFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
            ),
            onChanged: (value) {},
            items: ['Name', 'Popularity', 'Newest', 'Nearest']
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
          ),
        if (showDropdownMenu) const SizedBox(height: TSizes.spaceBtwSections),
        // Koas
        DGridLayout(
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          crossAxisCount: crossAxisCount,
          mainAxisExtent: mainAxisExtent,
        ),
      ],
    );
  }
}
