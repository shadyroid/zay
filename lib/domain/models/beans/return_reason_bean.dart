class ReturnReasonBean {
  final String value;
  final String label;

  const ReturnReasonBean({
    required this.value,
    required this.label,
  });

  factory ReturnReasonBean.fromJson(Map<String, dynamic> json) {
    return ReturnReasonBean(
      value: json['value'],
      label: json['label'],
    );
  }
}
