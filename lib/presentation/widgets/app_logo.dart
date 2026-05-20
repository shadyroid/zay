import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_icons.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 80});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppIcons.logo,
      width: size,
      height: size,
    );
  }
}
