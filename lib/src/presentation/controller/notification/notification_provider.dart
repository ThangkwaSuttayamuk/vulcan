import 'package:flutter_application_1/src/data/repositories/notification_repository_impl.dart';
import 'package:flutter_application_1/src/domain/repositories/notification_repository.dart';
import 'package:flutter_application_1/src/domain/usecases/add_notification_usecase.dart';
import 'package:flutter_application_1/src/domain/usecases/get_notification_usecase.dart';

import 'package:flutter_application_1/src/presentation/controller/notification/notification_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/notification/notification_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependency_injection.dart';

final notificationRepsitoryProvider =
Provider<NotificationRepository>((ref) => NotificationRepositoryImpl(sl()));

final addNotification =
Provider((ref) => AddNotificationUsecase(ref.read(notificationRepsitoryProvider)));

final getNotification =
    Provider((ref)=> GetNotificationUsecase(ref.read(notificationRepsitoryProvider)));

final notificationProvider =
StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(
      ref.read(addNotification),ref.read(getNotification));
});
