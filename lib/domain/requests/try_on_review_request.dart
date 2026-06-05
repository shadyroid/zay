import 'package:image_picker/image_picker.dart';

class TryOnReviewRequest {
  const TryOnReviewRequest({
    required this.tryOnId,
    required this.rate,
  });

  final int? tryOnId;
  final int rate;
}
