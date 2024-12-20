import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.widht = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.margin,
    this.backgroundColor = TColors.white,
    this.child,
  });

  final double? widht;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widht,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
