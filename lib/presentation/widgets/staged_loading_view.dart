import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingStage {
  const LoadingStage({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });

  final IconData icon;
  final String titleKey;
  final String descriptionKey;
}

class StagedLoadingView extends StatefulWidget {
  const StagedLoadingView({
    super.key,
    required this.headerIcon,
    required this.titleKey,
    required this.subtitleKey,
    required this.stages,
  });

  factory StagedLoadingView.tryOn({Key? key}) {
    return StagedLoadingView(
      key: key,
      headerIcon: Icons.checkroom_outlined,
      titleKey: 'waitingForTryOn',
      subtitleKey: 'waitingForTryOnSubtitle',
      stages: const [
        LoadingStage(
          icon: Icons.checkroom_outlined,
          titleKey: 'tryOnStepPreparing',
          descriptionKey: 'tryOnStepPreparingDesc',
        ),
        LoadingStage(
          icon: Icons.person_outline_rounded,
          titleKey: 'tryOnStepProcessing',
          descriptionKey: 'tryOnStepProcessingDesc',
        ),
        LoadingStage(
          icon: Icons.auto_awesome_outlined,
          titleKey: 'tryOnStepAlmostThere',
          descriptionKey: 'tryOnStepAlmostThereDesc',
        ),
        LoadingStage(
          icon: Icons.check_rounded,
          titleKey: 'tryOnStepDone',
          descriptionKey: 'tryOnStepDoneDesc',
        ),
      ],
    );
  }

  factory StagedLoadingView.imageSearch({Key? key}) {
    return StagedLoadingView(
      key: key,
      headerIcon: Icons.search_rounded,
      titleKey: 'searchingImages',
      subtitleKey: 'searchingImagesSubtitle',
      stages: const [
        LoadingStage(
          icon: Icons.search_rounded,
          titleKey: 'imageSearchStepSearching',
          descriptionKey: 'imageSearchStepSearchingDesc',
        ),
        LoadingStage(
          icon: Icons.apps_rounded,
          titleKey: 'imageSearchStepFiltering',
          descriptionKey: 'imageSearchStepFilteringDesc',
        ),
        LoadingStage(
          icon: Icons.tune_rounded,
          titleKey: 'imageSearchStepRanking',
          descriptionKey: 'imageSearchStepRankingDesc',
        ),
        LoadingStage(
          icon: Icons.check_rounded,
          titleKey: 'imageSearchStepDone',
          descriptionKey: 'imageSearchStepDoneDesc',
        ),
      ],
    );
  }

  final IconData headerIcon;
  final String titleKey;
  final String subtitleKey;
  final List<LoadingStage> stages;

  static const Color background = Color(0xFF0B1424);
  static const Color accent = Color(0xFF3D9BFF);
  static const Color muted = Color(0xFF8A9BB5);
  static const Color track = Color(0xFF1E2A3D);
  static const Color inactiveBorder = Color(0xFF2A3A52);

  @override
  State<StagedLoadingView> createState() => _StagedLoadingViewState();
}

class _StagedLoadingViewState extends State<StagedLoadingView>
    with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final AnimationController _stripeController;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    );
    _progress = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );
    _stripeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _progressController.animateTo(0.92);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _stripeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: StagedLoadingView.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AnimatedBuilder(
            animation: Listenable.merge([_progress, _stripeController]),
            builder: (context, _) {
              final progress = _progress.value;
              final activeIndex = math.min(
                widget.stages.length - 1,
                (progress * widget.stages.length).floor(),
              );
              final stageProgress =
                  (progress * widget.stages.length) - activeIndex;

              return Column(
                children: [
                  const Spacer(flex: 2),
                  Icon(
                    widget.headerIcon,
                    size: 44,
                    color: StagedLoadingView.accent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.titleKey.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitleKey.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: StagedLoadingView.muted,
                      fontSize: 14,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _StagesRow(
                    stages: widget.stages,
                    activeIndex: activeIndex,
                    activeProgress: stageProgress.clamp(0.0, 1.0),
                  ),
                  const SizedBox(height: 36),
                  _StripedProgressBar(
                    progress: progress,
                    stripeOffset: _stripeController.value,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      color: StagedLoadingView.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StagesRow extends StatelessWidget {
  const _StagesRow({
    required this.stages,
    required this.activeIndex,
    required this.activeProgress,
  });

  final List<LoadingStage> stages;
  final int activeIndex;
  final double activeProgress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < stages.length; i++) ...[
          if (i > 0)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 27),
                child: _DottedConnector(isActive: i <= activeIndex),
              ),
            ),
          Expanded(
            flex: 2,
            child: _StageItem(
              stage: stages[i],
              isCompleted: i < activeIndex,
              isActive: i == activeIndex,
              progress: i == activeIndex
                  ? activeProgress
                  : i < activeIndex
                      ? 1
                      : 0,
            ),
          ),
        ],
      ],
    );
  }
}

class _StageItem extends StatelessWidget {
  const _StageItem({
    required this.stage,
    required this.isCompleted,
    required this.isActive,
    required this.progress,
  });

  final LoadingStage stage;
  final bool isCompleted;
  final bool isActive;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final highlight = isCompleted || isActive;

    return Column(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: CustomPaint(
            painter: _StageRingPainter(
              progress: progress,
              isActive: isActive || isCompleted,
              isDashed: !highlight,
            ),
            child: Center(
              child: Icon(
                stage.icon,
                size: 22,
                color: highlight
                    ? Colors.white
                    : StagedLoadingView.muted.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          stage.titleKey.tr,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: highlight
                ? StagedLoadingView.accent
                : StagedLoadingView.muted.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stage.descriptionKey.tr,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: StagedLoadingView.muted,
            fontSize: 10,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _DottedConnector extends StatelessWidget {
  const _DottedConnector({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 3.0;
        const dashSpace = 3.0;
        final count =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor().clamp(1, 40);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (index) {
            return Container(
              width: dashWidth,
              height: 1.5,
              margin: const EdgeInsets.symmetric(horizontal: dashSpace / 2),
              color: isActive
                  ? StagedLoadingView.accent.withValues(alpha: 0.55)
                  : StagedLoadingView.inactiveBorder,
            );
          }),
        );
      },
    );
  }
}

class _StripedProgressBar extends StatelessWidget {
  const _StripedProgressBar({
    required this.progress,
    required this.stripeOffset,
  });

  final double progress;
  final double stripeOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fillWidth = (width * progress).clamp(0.0, width);

        return SizedBox(
          height: 14,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: StagedLoadingView.track,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              if (fillWidth > 0)
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SizedBox(
                      width: fillWidth,
                      height: 14,
                      child: CustomPaint(
                        painter: _StripedFillPainter(offset: stripeOffset),
                      ),
                    ),
                  ),
                ),
              if (fillWidth > 0)
                PositionedDirectional(
                  start: (fillWidth - 10).clamp(0.0, width),
                  top: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.95),
                      boxShadow: [
                        BoxShadow(
                          color: StagedLoadingView.accent.withValues(alpha: 0.85),
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StageRingPainter extends CustomPainter {
  _StageRingPainter({
    required this.progress,
    required this.isActive,
    required this.isDashed,
  });

  final double progress;
  final bool isActive;
  final bool isDashed;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = isDashed
          ? StagedLoadingView.inactiveBorder
          : StagedLoadingView.accent.withValues(alpha: 0.25);

    if (isDashed) {
      const dashCount = 28;
      const gapFactor = 0.45;
      final sweep = (2 * math.pi) / dashCount;
      for (var i = 0; i < dashCount; i++) {
        canvas.drawArc(
          rect,
          -math.pi / 2 + i * sweep,
          sweep * (1 - gapFactor),
          false,
          basePaint,
        );
      }
    } else {
      canvas.drawCircle(center, radius, basePaint);
    }

    if (isActive && progress > 0) {
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..color = StagedLoadingView.accent;
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress.clamp(0.05, 1.0),
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StageRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isActive != isActive ||
        oldDelegate.isDashed != isDashed;
  }
}

class _StripedFillPainter extends CustomPainter {
  _StripedFillPainter({required this.offset});

  final double offset;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = StagedLoadingView.accent;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(999),
      ),
      fillPaint,
    );

    final stripePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 8;

    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(999),
      ),
    );

    const spacing = 16.0;
    final shift = offset * spacing;
    for (var x = -size.height - spacing; x < size.width + size.height; x += spacing) {
      final startX = x + shift;
      canvas.drawLine(
        Offset(startX, size.height + 4),
        Offset(startX + size.height + 4, -4),
        stripePaint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _StripedFillPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
