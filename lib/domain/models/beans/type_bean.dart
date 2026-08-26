import 'package:zay/app/utils/parser.dart';

class TypeBean {
  final String? id;
  final String? name;

  const TypeBean({required this.id, required this.name});

  factory TypeBean.fromJson(Map<String, dynamic> json) {
    return TypeBean(
      id: Parser.parseString(json['id']),
      name: Parser.parseString(json['name']),
    );
  }
}
