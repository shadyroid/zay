import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';

abstract final class ImagesViewer {
  static Future<T?> open<T>({
    required List<String> images,
    int index = 0,
  }) {
    final urls = images
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
    if (urls.isEmpty) return Future<T?>.value(null);

    final safeIndex = index.clamp(0, urls.length - 1);
    return Get.toNamed<T>(
      Routes.imagesViewer,
      arguments: {
        'images': urls,
        'index': safeIndex,
      },
    ) ?? Future<T?>.value(null);
  }

  static Future<T?> openSingle<T>(String? image) {
    final url = image?.trim() ?? '';
    if (url.isEmpty) return Future<T?>.value(null);
    return open<T>(images: [url]);
  }
}
