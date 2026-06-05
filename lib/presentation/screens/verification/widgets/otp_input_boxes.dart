import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OtpInputBoxes extends StatelessWidget {
  const OtpInputBoxes({
    super.key,
    required this.code,
    required this.controller,
    required this.focusNode,
    this.length = 6,
  });

  final String code;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final gapTotal = gap * (length - 1);
        final boxSize =
            ((constraints.maxWidth - gapTotal) / length).clamp(44.0, 52.0);

        return SizedBox(
          height: boxSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.01,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: length,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(length),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(color: Colors.transparent),
                    cursorColor: Colors.transparent,
                    showCursor: false,
                  ),
                ),
              ),
              Row(
                children: List.generate(length, (index) {
                  final digit = index < code.length ? code[index] : '';
                  final activeIndex =
                      code.length < length ? code.length : length - 1;
                  final isFocused =
                      focusNode.hasFocus && index == activeIndex;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: index < length - 1 ? gap : 0,
                      ),
                      child: GestureDetector(
                        onTap: () => focusNode.requestFocus(),
                        child: _OtpBox(
                          digit: digit,
                          size: boxSize,
                          isFocused: isFocused,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.digit,
    required this.size,
    required this.isFocused,
  });

  final String digit;
  final double size;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused ? AppColors.primary : AppColors.border,
          width: isFocused ? 1.5 : 1,
        ),
      ),
      child: Text(
        digit,
        style: Get.theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
