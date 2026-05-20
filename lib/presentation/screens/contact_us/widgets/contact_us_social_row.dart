import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_icons.dart';

class ContactUsSocialRow extends StatelessWidget {
  const ContactUsSocialRow({
    super.key,
    required this.onWhatsApp,
    required this.onFacebook,
    required this.onTwitter,
  });

  final VoidCallback onWhatsApp;
  final VoidCallback onFacebook;
  final VoidCallback onTwitter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconButton(
          iconPath: AppIcons.whatsapp,
          onTap: onWhatsApp,
        ),
        const SizedBox(width: 16),
        _SocialIconButton(
          iconPath: AppIcons.facebook,
          onTap: onFacebook,
        ),
        const SizedBox(width: 16),
        _SocialIconButton(
          iconPath: AppIcons.twitter,
          onTap: onTwitter,
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    required this.iconPath,
    required this.onTap,
  });

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SvgPicture.asset(
        iconPath,
        width: 44,
        height: 44,
      ),
    );
  }
}
