import 'package:image_picker/image_picker.dart';

class TryProductRequest {
  const TryProductRequest({
    required this.productId,
    required this.image,
  });

  final int? productId;
  final XFile image;
}
