import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OrderDetailsSectionCard extends StatelessWidget {
  const OrderDetailsSectionCard({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.subtitle,
  });

  final String? title;
  final Widget? trailing;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                        ),
                      ),
                      ?trailing,
                    ],
                  ),
                  if (subtitle case final subtitleText?) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitleText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
          ],
          child,
        ],
      ),
    );
  }
}
