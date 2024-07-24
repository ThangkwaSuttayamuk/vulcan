class PushNotificationEntity {
  final String title;
  final String? body;
  final String dataTitle;
  final String? dataBody;
  // final String navigator;

  PushNotificationEntity(
      {required this.title,
      this.body,
      required this.dataTitle,
      this.dataBody,
      // required this.navigator
      });
}
