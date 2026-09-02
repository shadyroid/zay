import 'package:get/get.dart';
import 'package:zay/app/utils/parser.dart';

class CityBean {
  const CityBean({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int id;
  final String nameAr;
  final String nameEn;

  factory CityBean.fromJson(Map<String, dynamic> json) {
    return CityBean(
      id: Parser.parseInt(json['id']) ?? 0,
      nameAr: json['name_ar']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? '',
    );
  }

  String get displayName {
    final isArabic = (Get.locale?.languageCode ?? 'ar') == 'ar';
    if (isArabic) {
      return nameAr.isNotEmpty ? nameAr : nameEn;
    }
    return nameEn.isNotEmpty ? nameEn : nameAr;
  }

  List<String> get matchLabels => [
        nameEn,
        nameAr,
      ].where((e) => e.trim().isNotEmpty).toList();
}
