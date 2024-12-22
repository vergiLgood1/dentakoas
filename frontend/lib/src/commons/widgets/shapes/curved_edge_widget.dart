import 'package:denta_koas/src/commons/widgets/shapes/custom_curved_edge.dart';
import 'package:flutter/material.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdge(),
      child: child,
    );
  }
}
