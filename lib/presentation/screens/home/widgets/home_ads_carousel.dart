import 'package:flutter/material.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/ad_bean.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class HomeAdsCarousel extends StatelessWidget {
  const HomeAdsCarousel({
    super.key,
    required this.ads,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<AdBean> ads;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  static const double _aspectRatio = 1.2;

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _aspectRatio,
          child: PageView.builder(
            itemCount: ads.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return AppImage.network(
                ads[index].image ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        if (ads.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(ads.length, (index) {
                final active = index == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: active ? 20 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
