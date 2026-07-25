import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

/// App-wide motion tokens — subtle, commerce-friendly, Material 3 paced.
abstract final class AppMotion {
  static const Duration instant = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration page = Duration(milliseconds: 320);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.easeOut;

  /// Default GetX page transition for push / replace.
  static const Transition pageTransition = Transition.fadeIn;

  /// Bottom-nav tab swaps (no directional slide).
  static const Transition tabTransition = Transition.noTransition;

  static const int staggerStepMs = 45;
  static const int maxStaggerIndex = 12;
}

/// Shared entrance / interaction helpers built on [flutter_animate].
extension AppAnimateX on Widget {
  /// Fade + slight upward slide — section / screen content entrance.
  Widget animateEntrance({
    Duration delay = Duration.zero,
    Duration? duration,
  }) {
    final d = duration ?? AppMotion.normal;
    return animate(delay: delay)
        .fadeIn(duration: d, curve: AppMotion.standard)
        .slideY(
          begin: 0.05,
          end: 0,
          duration: d,
          curve: AppMotion.standard,
        );
  }

  /// Staggered list / grid entrance (capped so long lists stay snappy).
  Widget animateStagger(
    int index, {
    int stepMs = AppMotion.staggerStepMs,
    Duration? duration,
  }) {
    final capped = index.clamp(0, AppMotion.maxStaggerIndex);
    return animateEntrance(
      delay: Duration(milliseconds: capped * stepMs),
      duration: duration,
    );
  }

  /// Soft scale-in — icons, empty states, success marks.
  Widget animateScaleIn({
    Duration delay = Duration.zero,
    double begin = 0.86,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: AppMotion.normal, curve: AppMotion.standard)
        .scale(
          begin: Offset(begin, begin),
          end: const Offset(1, 1),
          duration: AppMotion.normal,
          curve: AppMotion.decelerate,
        );
  }

  /// Horizontal slide-in for carousel / row cards.
  Widget animateSlideIn({
    Duration delay = Duration.zero,
    double beginX = 0.08,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: AppMotion.normal, curve: AppMotion.standard)
        .slideX(
          begin: beginX,
          end: 0,
          duration: AppMotion.normal,
          curve: AppMotion.standard,
        );
  }
}

/// Press feedback: scales down while the finger is down.
class AnimatedPress extends StatefulWidget {
  const AnimatedPress({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.97,
    this.borderRadius,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final BorderRadius? borderRadius;
  final bool enabled;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || widget.onTap == null) return;
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1,
        duration: AppMotion.instant,
        curve: AppMotion.standard,
        child: widget.borderRadius != null
            ? ClipRRect(
                borderRadius: widget.borderRadius!,
                child: widget.child,
              )
            : widget.child,
      ),
    );
  }
}

/// Cross-fades between loading / empty / content without abrupt swaps.
class AnimatedStateSwitcher extends StatelessWidget {
  const AnimatedStateSwitcher({
    super.key,
    required this.child,
    this.duration = AppMotion.normal,
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: AppMotion.standard,
      switchOutCurve: AppMotion.emphasized,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.02),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
