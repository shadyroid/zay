class ContactUsRequest {
  const ContactUsRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
  });

  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
}
