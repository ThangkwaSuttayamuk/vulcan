import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_notification_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_notification_usecase.dart';

import 'package:flutter_application_1/src/presentation/controller/notification/notification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final AddNotificationUsecase addNotificationUsecase;
  final GetNotificationUsecase getNotificationUsecase;

  NotificationNotifier(this.addNotificationUsecase, this.getNotificationUsecase)
      : super(NotificationState());

  Future<void> addNotification(
      String title, String period, String description, String image) async {
    print('เข้า');
    final params =
        AddNotificationUsecaseTypeParam(title, period, description, image);
    await addNotificationUsecase.call(params);
  }

  Future<void> notificationList() async {
    final orderList = await getNotificationUsecase.call(NoParams());
    state = state.copyWith(
      notificationList: orderList,
    );
  }
}
