import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zay/app/use_cases/notifications_use_case.dart';
import 'package:zay/domain/models/beans/notification_bean.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class NotificationsController extends BaseController {
  final NotificationsUseCase _notificationsUseCase = Get.put(
    NotificationsUseCase(),
  );

  late final PagingController<int, NotificationBean> pagingController;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController<int, NotificationBean>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        final lastPage = state.pages?.lastOrNull;
        if (lastPage != null &&
            lastPage.length < NotificationsRequest.pageSize) {
          return null;
        }
        return state.nextIntPageKey;
      },
      fetchPage: requestNotifications,
    );
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<List<NotificationBean>> requestNotifications(int pageKey) async {
    final response = await _notificationsUseCase.requestNotifications(
      NotificationsRequest(page: pageKey),
    );
    if (!isSuccess(response)) {
      throw Exception(response.message ?? 'warning'.tr);
    }
    return response.data ?? [];
  }

  Future<void> onPullToRefresh() async {
    pagingController.refresh();
  }
}
