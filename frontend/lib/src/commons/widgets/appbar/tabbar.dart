import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/device/device_utility.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabBarApp extends StatelessWidget implements PreferredSizeWidget {
  const TabBarApp({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor = TColors.primary,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.dividerColor,
    this.dividerHeight,
    this.labelColor = TColors.primary,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor = TColors.darkGrey,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment = TabAlignment.fill,
    this.textScaler,
    this.indicatorAnimation,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final Color? indicatorColor;
  final bool automaticIndicatorColorAdjustment;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration? indicator;
  final TabBarIndicatorSize? indicatorSize;
  final Color? dividerColor;
  final double? dividerHeight;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;
  final DragStartBehavior dragStartBehavior;
  final WidgetStateProperty<Color?>? overlayColor;
  final MouseCursor? mouseCursor;
  final bool? enableFeedback;
  final void Function(int)? onTap;
  final ScrollPhysics? physics;
  final InteractiveInkFeatureFactory? splashFactory;
  final BorderRadius? splashBorderRadius;
  final TabAlignment? tabAlignment;
  final TextScaler? textScaler;
  final TabIndicatorAnimation? indicatorAnimation;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        isScrollable: isScrollable,
        padding: padding,
        indicatorColor: indicatorColor,
        automaticIndicatorColorAdjustment: automaticIndicatorColorAdjustment,
        indicatorWeight: indicatorWeight,
        indicatorPadding: indicatorPadding,
        indicator: indicator,
        indicatorSize: indicatorSize,
        dividerColor: dividerColor,
        dividerHeight: dividerHeight,
        labelColor: labelColor,
        labelStyle: labelStyle,
        labelPadding: labelPadding,
        unselectedLabelColor: unselectedLabelColor,
        unselectedLabelStyle: unselectedLabelStyle,
        dragStartBehavior: dragStartBehavior,
        mouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        onTap: onTap,
        physics: physics,
        splashFactory: splashFactory,
        tabAlignment: tabAlignment,
        textScaler: textScaler,
        indicatorAnimation: indicatorAnimation,
        overlayColor: WidgetStateProperty.all(Colors.blue.shade50),
        splashBorderRadius: splashBorderRadius,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
