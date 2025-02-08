import 'package:denta_koas/src/commons/widgets/containers/searchable_container.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/search_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// class SortableField extends StatelessWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final int crossAxisCount;
//   final double? mainAxisExtent;
//   final bool showDropdownMenu;
//   final bool showSearchBar;

//   const SortableField({
//     super.key,
//     required this.itemCount,
//     required this.itemBuilder,
//     this.crossAxisCount = 2,
//     this.mainAxisExtent,
//     this.showDropdownMenu = true,
//     this.showSearchBar = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (showDropdownMenu)
//           const DDropdownMenu(
//             items: [
//               'Name',
//               'University',
//               'Treatment',
//               'Title',
//               'Popularity',
//               'Newest',
//               'oldest'
//             ],
//             hintText: 'Sort by...',
//             prefixIcon: Iconsax.sort,
//           ),
//         // DropdownButtonFormField(
//         //   decoration: const InputDecoration(
//         //     prefixIcon: Icon(Iconsax.sort),
//         //   ),
//         //   onChanged: (value) {},
//         //   items: ['Name', 'Popularity', 'Newest', 'Nearest']
//         //       .map((option) => DropdownMenuItem(
//         //             value: option,
//         //             child: Text(option),
//         //           ))
//         //       .toList(),
//         // ),
//         const SizedBox(height: TSizes.spaceBtwSections),
//         if (showSearchBar)
//           const SearchContainer(
//             text: 'Search something...',
//             showBackground: false,
//             padding: EdgeInsets.all(0),
//           ),
//         if (showDropdownMenu) const SizedBox(height: TSizes.spaceBtwSections),
//         // Koas
//         DGridLayout(
//           itemCount: itemCount,
//           itemBuilder: itemBuilder,
//           crossAxisCount: crossAxisCount,
//           mainAxisExtent: mainAxisExtent,
//         ),
//       ],
//     );
//   }
// }

// modified_sortable_field.dart
// class SortableField extends StatelessWidget {
//   final int? itemCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final int crossAxisCount;
//   final double? mainAxisExtent;
//   final bool showDropdownMenu;
//   final bool showSearchBar;

//   final SearchPostController searchController = Get.put(SearchPostController());

//   SortableField({
//     super.key,
//     this.itemCount,
//     required this.itemBuilder,
//     this.crossAxisCount = 2,
//     this.mainAxisExtent,
//     this.showDropdownMenu = true,
//     this.showSearchBar = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (showDropdownMenu)
//           DDropdownMenu(
//             items: const [
//               'Name',
//               'University',
//               'Treatment',
//               'Title',
//               'Popularity',
//               'Newest',
//               'Oldest'
//             ],
//             hintText: 'Sort by...',
//             prefixIcon: Iconsax.sort,
//             onChanged: (value) {
//               if (value != null) {
//                 searchController.setSort(value);
//               }
//             },
//           ),
//         const SizedBox(height: TSizes.spaceBtwSections),
//         if (showSearchBar)
//           const ImprovedSearchContainer(
//             text: 'Search something...',
//             showBackground: false,
//             padding: EdgeInsets.all(0),
//           ),
//         if (showDropdownMenu) const SizedBox(height: TSizes.spaceBtwSections),
//         Obx(() {
//           final sortedPosts = searchController.getSortedPosts();
//           return DGridLayout(
//             itemCount: sortedPosts.length,
//             itemBuilder: (context, index) => itemBuilder(context, index),
//             crossAxisCount: crossAxisCount,
//             mainAxisExtent: mainAxisExtent,
//           );
//         }),
//       ],
//     );
//   }
// }

// Modify SortableField to use the new search container
class SortableField extends StatelessWidget {
  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double? mainAxisExtent;
  final bool showDropdownMenu;
  final bool showSearchBar;

  final SearchPostController searchController = Get.put(SearchPostController());

  SortableField({
    super.key,
    this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisExtent,
    this.showDropdownMenu = true,
    this.showSearchBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDropdownMenu)
          DDropdownMenu(
            items: const [
              'Name',
              'University',
              'Treatment',
              'Title',
              'Popularity',
              'Newest',
              'Oldest'
            ],
            hintText: 'Sort by...',
            prefixIcon: Iconsax.sort,
            onChanged: (value) {
              if (value != null) {
                searchController.setSort(value);
              }
            },
          ),
        const SizedBox(height: TSizes.spaceBtwSections),
        if (showSearchBar)
          const ImprovedSearchContainer(
            text: 'Search something...',
            showBackground: false,
            padding: EdgeInsets.all(0),
          ),
        if (showDropdownMenu) const SizedBox(height: TSizes.spaceBtwSections),
        Obx(() {
          final sortedPosts = searchController.getSortedPosts();
          return DGridLayout(
            itemCount: sortedPosts.length,
            itemBuilder: (context, index) => itemBuilder(context, index),
            crossAxisCount: crossAxisCount,
            mainAxisExtent: mainAxisExtent,
          );
        }),
      ],
    );
  }
}
