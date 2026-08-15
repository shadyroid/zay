import 'package:get/get.dart';
import 'package:zay/presentation/screens/payment_webview/screen.dart';

/// Opens [paymentUrl] in an in-app webview and completes when the screen is closed.
class PaymentBrowser {
  PaymentBrowser._();

  static Future<bool> openAndWaitForReturn(String paymentUrl) async {
    final uri = Uri.tryParse(paymentUrl);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      return false;
    }

    final result = await Get.to<bool>(
      () => PaymentWebViewScreen(url: paymentUrl),
      fullscreenDialog: true,
    );
    return result ?? true;
  }
}
