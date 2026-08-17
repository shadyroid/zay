import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/presentation/screens/review/controller.dart';

class ReviewBottomSheetController extends ReviewController {
  ReviewBottomSheetController({
    required int orderId,
    required OrderProductBean item,
  }) : super(orderId: orderId, items: [item]);
}
