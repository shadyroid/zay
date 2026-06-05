import 'package:get/get.dart';

class LikesUtil {
  static final productsLikes = <int, RxBool>{}.obs;

  static RxBool productLike(int? id, {bool? isFavorite}) {
    if (productsLikes.containsKey(id)) {
      if (isFavorite != null) {
        productsLikes[id]!.value = isFavorite;
      }
      return productsLikes[id]!;
    }

    final liked = RxBool(isFavorite ?? false);
    if(id!=null) productsLikes[id] = liked;
    return liked;
  }

  static void syncProductFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id == null) return;

    final isFavorite = json['is_favorite'];

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
