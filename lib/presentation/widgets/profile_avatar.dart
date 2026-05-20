import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_assets.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.size = 88,
    this.imagePath,
  });

  final double size;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: imagePath != null && imagePath!.isNotEmpty
            ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return SvgPicture.asset(
      AppAssets.profileAvatar,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
