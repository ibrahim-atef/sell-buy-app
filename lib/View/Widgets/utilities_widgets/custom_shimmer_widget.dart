import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  const CustomShimmer({
    Key? key,
    required this.child,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}