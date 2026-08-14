import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/transfer_progress.dart';

enum StagedLoadingStyle { cards, compact }

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
    required this.style,
    required this.sendProgress,
    required this.receiveProgress,
  });

  factory StagedLoadingView.tryOn({
    Key? key,
    required double sendProgress,
    required double receiveProgress,
  }) {
    return StagedLoadingView(
      key: key,
      headerIcon: Icons.checkroom_outlined,
      titleKey: 'waitingForTryOn',
      subtitleKey: 'waitingForTryOnSubtitle',
      style: StagedLoadingStyle.cards,
      sendProgress: sendProgress,
      receiveProgress: receiveProgress,
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

  factory StagedLoadingView.imageSearch({
    Key? key,
    required double sendProgress,
    required double receiveProgress,
  }) {
    return StagedLoadingView(
      key: key,
      headerIcon: Icons.search_rounded,
      titleKey: 'searchingImages',
      subtitleKey: 'searchingImagesSubtitle',
      style: StagedLoadingStyle.compact,
      sendProgress: sendProgress,
      receiveProgress: receiveProgress,
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
  final StagedLoadingStyle style;
  final double sendProgress;
  final double receiveProgress;

  static const Color background = Color(0xFFF7F9FC);
  static const Color title = Color(0xFF0B3A8C);
  static const Color accent = Color(0xFF2F80ED);
  static const Color muted = Color(0xFF8A94A6);
  static const Color track = Color(0xFFE6EAF0);
  static const Color inactiveBorder = Color(0xFFD5DBE5);
  static const Color cardBackground = Colors.white;

  @override
  State<StagedLoadingView> createState() => _StagedLoadingViewState();
}

class _StagedLoadingViewState extends State<StagedLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _stripeController;

  @override
  void initState() {
    super.initState();
    _stripeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _stripeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stageProgresses = TransferProgress.stageProgresses(
      sendProgress: widget.sendProgress,
      receiveProgress: widget.receiveProgress,
    );
    final progress = TransferProgress.overall(
      sendProgress: widget.sendProgress,
      receiveProgress: widget.receiveProgress,
    );
    final activeIndex = stageProgresses.indexWhere((value) => value < 1);
    final resolvedActiveIndex =
        activeIndex == -1 ? stageProgresses.length - 1 : activeIndex;

    return ColoredBox(
      color: StagedLoadingView.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedBuilder(
            animation: _stripeController,
            builder: (context, _) {
              return Column(
                children: [
                  const Spacer(flex: 2),
                  Icon(
                    widget.headerIcon,
                    size: 42,
                    color: StagedLoadingView.accent,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.titleKey.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: StagedLoadingView.title,
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
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (widget.style == StagedLoadingStyle.cards)
                    _CardStagesRow(
                      stages: widget.stages,
                      stageProgresses: stageProgresses,
                      activeIndex: resolvedActiveIndex,
                    )
                  else
                    _CompactStagesRow(
                      stages: widget.stages,
                      stageProgresses: stageProgresses,
                      activeIndex: resolvedActiveIndex,
                    ),
                  const SizedBox(height: 28),
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

class _CardStagesRow extends StatelessWidget {
  const _CardStagesRow({
    required this.stages,
    required this.stageProgresses,
    required this.activeIndex,
  });

  final List<LoadingStage> stages;
  final List<double> stageProgresses;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < stages.length; i++) ...[
          if (i > 0)
            Padding(
              padding: const EdgeInsets.only(top: 36, left: 2, right: 2),
              child: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                size: 16,
                color: StagedLoadingView.inactiveBorder,
              ),
            ),
          Expanded(
            child: _StageCard(
              stage: stages[i],
              isCompleted: stageProgresses[i] >= 1,
              isActive: i == activeIndex,
              progress: stageProgresses[i],
            ),
          ),
        ],
      ],
    );
  }
}

class _StageCard extends StatelessWidget {
  const _StageCard({
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

    return Container(
      padding: const EdgeInsets.fromLTRB(6, 14, 6, 12),
      decoration: BoxDecoration(
        color: StagedLoadingView.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _StageRing(
            icon: stage.icon,
            progress: progress,
            isActive: isActive || isCompleted,
            isDashed: !highlight,
            size: 44,
            iconSize: 20,
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
                  : StagedLoadingView.title.withValues(alpha: 0.75),
              fontSize: 11,
              fontWeight: FontWeight.w700,
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
              fontSize: 9,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactStagesRow extends StatelessWidget {
  const _CompactStagesRow({
    required this.stages,
    required this.stageProgresses,
    required this.activeIndex,
  });

  final List<LoadingStage> stages;
  final List<double> stageProgresses;
  final int activeIndex;

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
                child: _DottedConnector(isActive: stageProgresses[i] > 0 || i <= activeIndex),
              ),
            ),
          Expanded(
            flex: 2,
            child: _CompactStageItem(
              stage: stages[i],
              isCompleted: stageProgresses[i] >= 1,
              isActive: i == activeIndex,
              progress: stageProgresses[i],
            ),
          ),
        ],
      ],
    );
  }
}

class _CompactStageItem extends StatelessWidget {
  const _CompactStageItem({
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
        _StageRing(
          icon: stage.icon,
          progress: progress,
          isActive: isActive || isCompleted,
          isDashed: !highlight,
          size: 56,
          iconSize: 22,
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
                : StagedLoadingView.title.withValues(alpha: 0.7),
            fontSize: 12,
            fontWeight: FontWeight.w700,
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

class _StageRing extends StatelessWidget {
  const _StageRing({
    required this.icon,
    required this.progress,
    required this.isActive,
    required this.isDashed,
    required this.size,
    required this.iconSize,
  });

  final IconData icon;
  final double progress;
  final bool isActive;
  final bool isDashed;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _StageRingPainter(
          progress: progress,
          isActive: isActive,
          isDashed: isDashed,
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: isActive
                ? StagedLoadingView.accent
                : StagedLoadingView.muted,
          ),
        ),
      ),
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
        final count = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor()
            .clamp(1, 40);
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
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              StagedLoadingView.accent.withValues(alpha: 0.7),
                          blurRadius: 12,
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
          : StagedLoadingView.accent.withValues(alpha: 0.2);

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
      ..color = Colors.white.withValues(alpha: 0.28)
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
    for (var x = -size.height - spacing;
        x < size.width + size.height;
        x += spacing) {
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
