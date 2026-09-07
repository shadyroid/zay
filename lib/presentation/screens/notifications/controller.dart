import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zay/app/use_cases/notifications_use_case.dart';
import 'package:zay/app/utils/notifications_util.dart';
import 'package:zay/domain/models/beans/notification_bean.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/requests/read_notification_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/screens/home/controller.dart';

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

  Future<void> requestReadNotifications() async {
    isLoading.value = true;
    final response = await _notificationsUseCase.requestReadNotifications();
    isLoading.value = false;
    if (!isSuccess(response)) return;

    pagingController.mapItems((item) => item.copyWith(isRead: true));
    _syncHomeUnreadCount(0);
  }

  Future<void> onNotificationTap(NotificationBean notification) async {
    if (!notification.isRead && notification.id != null) {
      final response = await _notificationsUseCase.requestReadNotification(
        ReadNotificationRequest(notificationId: notification.id!),
      );
      if (isSuccess(response)) {
        pagingController.mapItems(
          (item) => item.id == notification.id
              ? item.copyWith(isRead: true)
              : item,
        );
        _decrementHomeUnreadCount();
      }
    }

    final data = notification.data;
    if (data == null || data.isEmpty) return;
    NotificationsUtil.navigateFromData(data);
  }

  void _syncHomeUnreadCount(int count) {
    if (!Get.isRegistered<HomeController>()) return;
    Get.find<HomeController>().unreadNotificationsCount.value = count;
  }

  void _decrementHomeUnreadCount() {
    if (!Get.isRegistered<HomeController>()) return;
    final home = Get.find<HomeController>();
    if (home.unreadNotificationsCount.value > 0) {
      home.unreadNotificationsCount.value--;
    }
  }
}
