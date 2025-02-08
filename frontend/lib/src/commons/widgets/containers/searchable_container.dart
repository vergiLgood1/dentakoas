import 'package:denta_koas/src/features/appointment/controller/search_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/device/device_utility.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// improved_search_container.dart
class ImprovedSearchContainer extends StatefulWidget {
  const ImprovedSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  State<ImprovedSearchContainer> createState() =>
      _ImprovedSearchContainerState();
}

class _ImprovedSearchContainerState extends State<ImprovedSearchContainer> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final SearchPostController searchController =
      Get.find<SearchPostController>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            color: TColors.white,
            elevation: 4.0,
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(TSizes.cardRadiusLg)),
            ),
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: searchController.suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchController.suggestions[index]),
                    onTap: () {
                      _searchController.text =
                          searchController.suggestions[index];
                      searchController
                          .updateSearch(searchController.suggestions[index]);
                      _hideOverlay();
                      _focusNode.unfocus();
                    },
                  );
                },
              );
            }),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(0),
        // decoration: BoxDecoration(
        //   color: widget.showBackground
        //       ? dark
        //           ? TColors.black
        //           : TColors.light
        //       : TColors.transparent,
        //   borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        //   border:
        //       widget.showBorder ? Border.all(color: TColors.darkGrey) : null,
        // ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.text,
                  border: InputBorder.none,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: TColors.darkGrey),
                  prefixIcon: Icon(
                    widget.icon ?? Iconsax.search_normal,
                    color: TColors.primary,
                  ),
                ),
                onChanged: (value) {
                  searchController.updateSearch(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
