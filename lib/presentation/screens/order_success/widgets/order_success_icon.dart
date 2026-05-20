import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class OrderSuccessIcon extends StatelessWidget {
  const OrderSuccessIcon({super.key});

  static const double size = 112;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.orderSuccess,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppIcons.check,
          width: 52,
          height: 52,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
