import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/add_notification_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_notification_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Cubit<dynamic> {
  final AddNotificationUsecase addNotificationUsecase;
  final GetNotificationUsecase getNotificationUsecase;

  NotificationBloc({
    required this.addNotificationUsecase,
    required this.getNotificationUsecase
  }) : super([]);

  void addToOrder(AddNotificationUsecaseTypeParam params) async {
    await addNotificationUsecase(params);
  }

  void getNotification() async {
    final notificationList = await getNotificationUsecase(NoParams());
    emit(notificationList);
  }

}
