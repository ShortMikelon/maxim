import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color baseColor = Colors.grey.shade300;
  final Color highlightColor = Colors.grey.shade100;

  AppShimmer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 500),
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}