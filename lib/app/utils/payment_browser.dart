import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [paymentUrl] externally and completes when the app returns to foreground.
class PaymentBrowser {
  PaymentBrowser._();

  static Future<bool> openAndWaitForReturn(String paymentUrl) async {
    final uri = Uri.tryParse(paymentUrl);
    if (uri == null) return false;

    final completer = Completer<bool>();
    var sawBackground = false;

    late final AppLifecycleListener listener;
    listener = AppLifecycleListener(
      onPause: () => sawBackground = true,
      onInactive: () => sawBackground = true,
      onResume: () {
        if (!sawBackground || completer.isCompleted) return;
        completer.complete(true);
      },
      onDetach: () {
        if (!completer.isCompleted) completer.complete(true);
      },
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      listener.dispose();
      return false;
    }

    try {
      return await completer.future.timeout(
        const Duration(minutes: 30),
        onTimeout: () => true,
      );
    } finally {
      listener.dispose();
    }
  }
}
