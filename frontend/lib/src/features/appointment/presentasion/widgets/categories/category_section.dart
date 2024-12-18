import 'package:denta_koas/src/features/appointment/presentasion/widgets/categories/category_item.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryItem(
            icon: Icons.coronavirus,
            label: "Covid 19",
          ),
          CategoryItem(
            icon: Icons.person,
            label: "Doctor",
          ),
          CategoryItem(
            icon: Icons.local_pharmacy,
            label: "Medicine",
          ),
          CategoryItem(
            icon: Icons.local_hospital,
            label: "Hospital",
          ),
        ],
      ),
    );
  }
}
