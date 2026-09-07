import 'dart:async';
import 'dart:math' as math;

abstract final class TransferProgress {
  /// Dio byte progress as a 0–1 portion of the current transfer phase.
  static double portion(int count, int total) {
    if (total > 0) return (count / total).clamp(0.0, 1.0);
    return count > 0 ? 0.99 : 0.0;
  }

  /// Upload is treated as finished so the fake receive half can start.
  static bool isSendComplete(double portion) => portion >= 0.99;

  /// Overall bar: send = 0–50%, receive = 50–100%.
  static double overall({
    required double sendProgress,
    required double receiveProgress,
  }) {
    return (sendProgress.clamp(0.0, 1.0) * 0.5) +
        (receiveProgress.clamp(0.0, 1.0) * 0.5);
  }

  /// Four stage rings: first two from send, last two from receive.
  static List<double> stageProgresses({
    required double sendProgress,
    required double receiveProgress,
  }) {
    final send = sendProgress.clamp(0.0, 1.0);
    final receive = receiveProgress.clamp(0.0, 1.0);
    return [
      (send * 2).clamp(0.0, 1.0),
      ((send - 0.5) * 2).clamp(0.0, 1.0),
      (receive * 2).clamp(0.0, 1.0),
      ((receive - 0.5) * 2).clamp(0.0, 1.0),
    ];
  }
}

/// Animates the receive half after upload, since Dio cannot report server work.
class FakeReceiveProgress {
  FakeReceiveProgress({
    this.duration = const Duration(seconds: 45),
    this.cap = 0.9,
    this.interval = const Duration(milliseconds: 50),
  });

  final Duration duration;
  final double cap;
  final Duration interval;

  Timer? _timer;

  bool get isRunning => _timer?.isActive == true;

  void start(void Function(double value) onTick) {
    if (isRunning) return;
    final startedAt = DateTime.now();
    _timer = Timer.periodic(interval, (timer) {
      final t = DateTime.now().difference(startedAt).inMilliseconds /
          duration.inMilliseconds;
      final clamped = t.clamp(0.0, 1.0);
      final eased = 1 - math.pow(1 - clamped, 2);
      onTick(eased * cap);
      if (clamped >= 1) timer.cancel();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
