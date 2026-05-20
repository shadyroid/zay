import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class VerificationKeypad extends StatelessWidget {
  const VerificationKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8E8E8),
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Column(
        children: [
          _KeypadRow(keys: const ['1', '2', '3'], onDigit: onDigit),
          const SizedBox(height: 7),
          _KeypadRow(keys: const ['4', '5', '6'], onDigit: onDigit),
          const SizedBox(height: 7),
          _KeypadRow(keys: const ['7', '8', '9'], onDigit: onDigit),
          const SizedBox(height: 7),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(child: _KeypadKey(label: '0', onTap: () => onDigit('0'))),
              Expanded(
                child: _KeypadKey(
                  onTap: onBackspace,
                  child: const Icon(
                    Icons.backspace_outlined,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeypadRow extends StatelessWidget {
  const _KeypadRow({required this.keys, required this.onDigit});

  final List<String> keys;
  final ValueChanged<String> onDigit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: keys
          .map(
            (key) => Expanded(
              child: _KeypadKey(label: key, onTap: () => onDigit(key)),
            ),
          )
          .toList(),
    );
  }
}

class _KeypadKey extends StatelessWidget {
  const _KeypadKey({this.label, this.onTap, this.child})
      : assert(label != null || child != null);

  final String? label;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 46,
            alignment: Alignment.center,
            child: child ??
                Text(
                  label!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}
