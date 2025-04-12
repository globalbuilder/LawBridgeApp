import 'package:flutter/foundation.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/api_client.dart';
import '../models/notification_model.dart';

abstract class INotificationsRemoteDataSource {
  /// Returns all notifications for the logged-in user
  Future<List<NotificationModel>> getNotifications();

  /// Fetches one notification, marking it read (is_read = true) in the process
  Future<NotificationModel> getNotificationDetail(int id);
}

class NotificationsRemoteDataSourceImpl
    implements INotificationsRemoteDataSource {
  final ApiClient apiClient;
  NotificationsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await apiClient.get(ApiEndpoints.notifications);
      final data = response as List<dynamic>;
      return data
          .map((json) => NotificationModel.fromJson(json))
          .toList(growable: false);
    } catch (e) {
      debugPrint('Error in getNotifications: $e');
      rethrow;
    }
  }

  @override
  Future<NotificationModel> getNotificationDetail(int id) async {
    try {
      final url = ApiEndpoints.notificationDetail.replaceAll('<id>', '$id');
      // PATCH sets is_read to true, returning the updated object
      final result = await apiClient.patch(url, body: {'is_read': 'true'});
      return NotificationModel.fromJson(result);
    } catch (e) {
      debugPrint('Error in getNotificationDetail: $e');
      rethrow;
    }
  }
}
