import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zay/app/utils/app_colors.dart';

class HomeShimmerBox extends StatelessWidget {
  const HomeShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
  });

  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE2E8F0),
      highlightColor: const Color(0xFFF7FAFC),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.screenBackground,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class HomeHorizontalSkeleton extends StatelessWidget {
  const HomeHorizontalSkeleton({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    this.itemCount = 4,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final double itemWidth;
  final double itemHeight;
  final int itemCount;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, _) => HomeShimmerBox(
          width: itemWidth,
          height: itemHeight,
        ),
      ),
    );
  }
}
