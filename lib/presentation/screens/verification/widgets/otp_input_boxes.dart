import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zay/app/utils/app_colors.dart';

class OtpInputBoxes extends StatelessWidget {
  const OtpInputBoxes({
    super.key,
    required this.controller,
    required this.focusNode,
    this.length = 6,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final gapTotal = gap * (length - 1);
        final boxSize =
            ((constraints.maxWidth - gapTotal) / length).clamp(44.0, 52.0);

        final textStyle = Get.theme.textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        );

        final defaultPinTheme = PinTheme(
          width: boxSize,
          height: boxSize,
          textStyle: textStyle,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
        );

        return AutofillGroup(
          child: Pinput(
            length: length,
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.oneTimeCode],
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyDecorationWith(
              border: Border.all(color: AppColors.primary, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            submittedPinTheme: defaultPinTheme,
            separatorBuilder: (_) => const SizedBox(width: gap),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}
