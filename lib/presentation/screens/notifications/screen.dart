import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/notification_bean.dart';
import 'package:zay/presentation/screens/notifications/controller.dart';
import 'package:zay/presentation/screens/notifications/widgets/notification_item.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';
import 'package:zay/presentation/widgets/empty_state.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'notifications'.tr,
        showDivider: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.onPullToRefresh,
        child: PagingListener<int, NotificationBean>(
          controller: controller.pagingController,
          builder: (context, state, fetchNextPage) {
            final items = state.pages?.expand((page) => page).toList() ?? [];

            return PagedListView<int, NotificationBean>(
              state: state,
              fetchNextPage: fetchNextPage,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              builderDelegate: PagedChildBuilderDelegate<NotificationBean>(
                itemBuilder: (context, notification, index) {
                  final showDateHeader = index == 0 ||
                      notification.dateGroupLabel !=
                          items[index - 1].dateGroupLabel;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showDateHeader &&
                          notification.dateGroupLabel.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 16, 4, 12),
                          child: Text(
                            notification.dateGroupLabel,
                            style: Get.theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                      NotificationItem(notification: notification)
                          .animateStagger(index),
                      const SizedBox(height: 12),
                    ],
                  );
                },
                firstPageProgressIndicatorBuilder: (_) =>
                    const Center(child: AppProgressIndicator()),
                newPageProgressIndicatorBuilder: (_) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: AppProgressIndicator()),
                ),
                noItemsFoundIndicatorBuilder: (_) => EmptyState(
                  message: 'noNotifications'.tr,
                  icon: Icons.notifications_none_outlined,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
