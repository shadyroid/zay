import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/presentation/widgets/app_image.dart';

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
    return SizedBox(
      width: size,
      height: size,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    final path = imagePath;
    if (path == null || path.isEmpty) {
      return _placeholder();
    }

    if (path.startsWith('http')) {
      return AppImage.network(
        path,
        width: size,
        height: size,
        fit: BoxFit.cover,
        shape: AppImageShape.circle,
        errorWidget: _placeholder(),
      );
    }

    return AppImage.file(
      path,
      width: size,
      height: size,
      fit: BoxFit.cover,
      shape: AppImageShape.circle,
      errorWidget: _placeholder(),
    );
  }

  Widget _placeholder() {
    return SvgPicture.asset(
      'assets/icons/ic_profile_avatar.svg',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
