import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';

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
          'assets/icons/ic_check.svg',
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
