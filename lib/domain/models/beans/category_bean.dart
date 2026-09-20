import 'package:zay/app/utils/parser.dart';

class CategoryBean {
  final int? id;
  final String? name;
  final String? measurementsImage;
  final bool? isTryOnEnabled;

  const CategoryBean({
    required this.id,
    required this.name,
    required this.measurementsImage,
    required this.isTryOnEnabled,
  });

  factory CategoryBean.fromJson(Map<String, dynamic> json) {
    return CategoryBean(
      id: json['id'],
      name: json['name'],
      measurementsImage: json['measurements_image'],
      isTryOnEnabled: json['is_try_on_enabled'] == null
          ? null
          : Parser.parseBoolean(json['is_try_on_enabled']),
    );
  }
}
