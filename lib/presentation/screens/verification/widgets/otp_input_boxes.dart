import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OtpInputBoxes extends StatelessWidget {
  const OtpInputBoxes({super.key, required this.code, this.length = 6});

  final String code;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final digit = index < code.length ? code[index] : '';
        final isLast = index == length - 1;

        return Padding(
          padding: EdgeInsetsDirectional.only(end: isLast ? 0 : 12),
          child: _OtpBox(digit: digit),
        );
      }),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.digit});

  final String digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        digit,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
