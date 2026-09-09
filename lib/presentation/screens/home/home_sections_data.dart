import 'package:zay/domain/models/beans/product_bean.dart';

class HomeSectionsData {
  const HomeSectionsData({
    this.recommendedProducts = const [],
    this.newArrivalProducts = const [],
  });

  final List<ProductBean> recommendedProducts;
  final List<ProductBean> newArrivalProducts;

  static const recommendedKey = 'recommendedProducts';
  static const newArrivalKey = 'newArrivalProducts';

  bool get isEmpty =>
      recommendedProducts.isEmpty && newArrivalProducts.isEmpty;

  factory HomeSectionsData.fromArguments([dynamic arguments]) {
    final args = arguments is Map ? arguments : null;
    return HomeSectionsData(
      recommendedProducts: _asProductList(args?[recommendedKey]),
      newArrivalProducts: _asProductList(args?[newArrivalKey]),
    );
  }

  Map<String, dynamic> toArguments() => {
        recommendedKey: recommendedProducts,
        newArrivalKey: newArrivalProducts,
      };

  Map<String, dynamic> mergeWith(Map<String, dynamic> extra) => {
        ...extra,
        ...toArguments(),
      };

  static List<ProductBean> _asProductList(dynamic value) {
    if (value is List<ProductBean>) return value;
    if (value is List) return value.whereType<ProductBean>().toList();
    return const [];
  }
}
