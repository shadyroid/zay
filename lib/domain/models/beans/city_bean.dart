class CityBean {
  const CityBean({
    required this.code,
    required this.name,
    required this.nameAr,
    required this.nameEn,
  });

  final String code;
  final String name;
  final String nameAr;
  final String nameEn;

  factory CityBean.fromJson(Map<String, dynamic> json) {
    return CityBean(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? json['name']?.toString() ?? '',
      nameEn: json['name_en']?.toString() ?? json['name']?.toString() ?? '',
    );
  }

  String get displayName {
    // Prefer localized label when available via Get locale is handled by caller.
    return name.isNotEmpty ? name : (nameEn.isNotEmpty ? nameEn : nameAr);
  }

  List<String> get matchLabels => [
        nameEn,
        nameAr,
        name,
      ].where((e) => e.trim().isNotEmpty).toList();
}
