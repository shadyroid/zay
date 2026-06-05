import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (leading != null) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: leading,
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
                const SizedBox(height: 32),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
