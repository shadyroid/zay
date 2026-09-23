import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/utils/constants.dart';

/// Handles HTTPS App Links / Universal Links for products and shops.
///
/// Expected URLs (host: [Constants.deepLinkHost]):
/// - `https://zaymarketplace.online/product/123`
/// - `https://zaymarketplace.online/shop/45`
///
/// Store fallback when the app is not installed is handled by the website
/// serving those paths (see setup notes after implementation).
class DeepLinksUtil {
  DeepLinksUtil._();

  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _linkSubscription;
  static bool _isInitialized = false;
  static Uri? _pendingUri;

  static Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      final initial = await _appLinks.getInitialLink();
      if (initial != null) _pendingUri = initial;
    } catch (e) {
      debugPrint('DeepLinksUtil: failed to read initial link: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (Object e) {
        debugPrint('DeepLinksUtil: link stream error: $e');
      },
    );
  }

  /// Call once navigation is ready (e.g. after splash → home/sign-in).
  static Future<void> handleInitialLink() async {
    final uri = _pendingUri;
    _pendingUri = null;
    if (uri != null) _navigateFromUri(uri);
  }

  static String productLink(int? productId) =>
      'https://${Constants.deepLinkHost}/product/$productId';

  static String shopLink(int shopId) =>
      'https://${Constants.deepLinkHost}/shop/$shopId';

  static Future<void> shareProduct({
    required int? productId,
    String? productName,
  }) {
    final url = productLink(productId);
    final text = productName == null || productName.isEmpty
        ? url
        : '$productName\n$url';
    return SharePlus.instance.share(ShareParams(text: text));
  }

  static Future<void> shareShop({
    required int shopId,
    String? shopName,
  }) {
    final url = shopLink(shopId);
    final text = shopName == null || shopName.isEmpty ? url : '$shopName\n$url';
    return SharePlus.instance.share(ShareParams(text: text));
  }

  static void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
    _isInitialized = false;
  }

  static void _handleUri(Uri uri) {
    if (Get.key.currentState == null) {
      _pendingUri = uri;
      return;
    }
    _navigateFromUri(uri);
  }

  static void _navigateFromUri(Uri uri) {
    if (!_isSupportedHost(uri.host)) return;

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (segments.length < 2) return;

    final type = segments[0].toLowerCase();
    final id = int.tryParse(segments[1]);
    if (id == null) return;

    if (type == 'product' || type == 'products') {
      Get.toNamed(Routes.productDetails, arguments: {'productId': id});
      return;
    }
    if (type == 'shop' || type == 'shops') {
      Get.toNamed(Routes.shopDetails, arguments: {'shopId': id});
    }
  }

  static bool _isSupportedHost(String host) {
    final normalized = host.toLowerCase();
    return normalized == Constants.deepLinkHost ||
        normalized == 'www.${Constants.deepLinkHost}';
  }
}
