import 'package:get/get.dart';

class LikesUtil {
  static final productsLikes = <String, RxBool>{}.obs;

  static RxBool productLike(String id, {bool? isFavorite}) {
    if (productsLikes.containsKey(id)) {
      if (isFavorite != null) {
        productsLikes[id]!.value = isFavorite;
      }
      return productsLikes[id]!;
    }

    final liked = RxBool(isFavorite ?? false);
    productsLikes[id] = liked;
    return liked;
  }

  static void syncProductFromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    if (id == null || id.isEmpty) return;

    final isFavorite = json['isFavorite'] as bool? ??
        json['is_favorite'] as bool? ??
        false;

    productLike(id, isFavorite: isFavorite);
  }

  static void syncProductsFromList(List<dynamic>? raw) {
    if (raw == null) return;

    for (final entry in raw) {
      if (entry is! Map) continue;
      final map = Map<String, dynamic>.from(entry);
      if (map['product'] is Map) {
        syncProductFromJson(Map<String, dynamic>.from(map['product'] as Map));
      } else {
        syncProductFromJson(map);
      }
    }
  }
}
