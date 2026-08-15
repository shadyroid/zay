import 'package:zay/app/utils/app_date_format.dart';

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

  /// Header label used to group notifications by day.
  String get dateGroupLabel => AppDateFormat.dayLabel(createdAt);
}
