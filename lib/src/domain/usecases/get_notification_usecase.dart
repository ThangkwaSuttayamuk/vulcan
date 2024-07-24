import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/entities/notification_entity.dart';
import 'package:flutter_application_1/src/domain/repositories/notification_repository.dart';

class GetNotificationUsecase implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationRepository repository;
  GetNotificationUsecase(this.repository);

  @override
  Future<List<NotificationEntity>> call(NoParams noParams) async {
    return await repository.getNotification();
  }
}
