import 'package:image_picker/image_picker.dart';

class TryOnRequest {
  const TryOnRequest({
    required this.productId,
    required this.image,
  });

  final int? productId;
  final XFile image;
}
