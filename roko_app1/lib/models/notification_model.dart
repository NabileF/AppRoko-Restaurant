// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roko_app1/models/notification_type.dart';

class NotificationModel {
  int notificationId;
  String content;
  DateTime timestamp;
  NotificationType notificationType;
  NotificationModel({
    required this.notificationId,
    required this.content,
    required this.timestamp,
    required this.notificationType,
  });
}
