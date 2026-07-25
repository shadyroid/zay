import 'package:get/get.dart';

class NotificationBean {
  final String? id;
  final String? title;
  final String? body;
  final String? imageUrl;
  final bool isRead;
  final String? createdAt;
  final Map<String, dynamic>? data;

  const NotificationBean({
    required this.id,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.isRead,
    required this.createdAt,
    required this.data,
  });

  factory NotificationBean.fromJson(Map<String, dynamic> json) {
    final payload = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : null;

    return NotificationBean(
      id: json['id']?.toString(),
      title: json['title'] ?? payload?['title'],
      body: json['body'] ?? json['message'] ?? payload?['body'],
      imageUrl: json['image_url'] ?? json['image'] ?? payload?['image_url'],
      isRead: json['is_read'] == true || json['read_at'] != null,
      createdAt: json['created_at'] ?? json['createdAt'],
      data: payload,
    );
  }

  NotificationBean copyWith({
    String? id,
    String? title,
    String? body,
    String? imageUrl,
    bool? isRead,
    String? createdAt,
    Map<String, dynamic>? data,
  }) {
    return NotificationBean(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      data: data ?? this.data,
    );
  }

  DateTime? get _createdAtDate => DateTime.tryParse(createdAt ?? '')?.toLocal();

  /// Header label used to group notifications by day.
  String get dateGroupLabel {
    final date = _createdAtDate;
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final day = DateTime(date.year, date.month, date.day);

    if (day == today) return 'today'.tr;
    if (day == yesterday) return 'yesterday'.tr;

    final month = date.month.toString().padLeft(2, '0');
    final dayOfMonth = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$dayOfMonth';
  }
}
