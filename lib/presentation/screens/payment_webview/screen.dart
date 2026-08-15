import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.url});

  final String url;

  static const _returnHost = 'zaymarketplace.online';

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  var _isLoading = true;
  var _didClose = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (_isReturnUrl(request.url)) {
              _close();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            if (_isReturnUrl(url)) {
              _close();
              return;
            }
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  bool _isReturnUrl(String url) {
    final host = Uri.tryParse(url)?.host.toLowerCase();
    if (host == null) return false;
    return host == PaymentWebViewScreen._returnHost ||
        host.endsWith('.${PaymentWebViewScreen._returnHost}');
  }

  void _close() {
    if (_didClose || !mounted) return;
    _didClose = true;
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(title: 'payNow'.tr),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
