abstract final class TransferProgress {
  /// Dio byte progress as a 0–1 portion of the current transfer phase.
  static double portion(int count, int total) {
    if (total > 0) return (count / total).clamp(0.0, 1.0);
    return count > 0 ? 0.99 : 0.0;
  }

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
