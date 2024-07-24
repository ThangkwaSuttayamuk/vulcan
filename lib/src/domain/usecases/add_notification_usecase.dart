import 'package:flutter_application_1/src/core/usecase/usecase.dart';
import 'package:flutter_application_1/src/domain/repositories/notification_repository.dart';
import 'package:flutter_application_1/src/domain/repositories/order_repository.dart';

class AddNotificationUsecase
    implements UseCase<void, AddNotificationUsecaseTypeParam> {
  final NotificationRepository repository;

  AddNotificationUsecase(this.repository);

  @override
  Future<void> call(AddNotificationUsecaseTypeParam params) async {
    await repository.addNotification(
        params.title, params.period, params.description, params.image);
  }
}

class AddNotificationUsecaseTypeParam {
  final String title;
  final String period;
  final String description;
  final String image;

  const AddNotificationUsecaseTypeParam(
      this.title, this.period, this.description, this.image);
}
