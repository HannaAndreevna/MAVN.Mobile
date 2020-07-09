import 'package:lykke_mobile_mavn/base/notification/notification_routes.dart';

class NotificationTapped {
  NotificationTapped(this.notificationTappedCustomPayload);

  NotificationTapped.fromJson(Map<String, dynamic> json) : this._fromMap(json);

  NotificationTapped.fromFirebaseNotification(Map<String, dynamic> json)
      : this._fromMap(json['data']);

  NotificationTapped._fromMap(Map<dynamic, dynamic> json) {
    final route = json['route'];
    final id = json['MessageGroupId'];
    switch (route) {
      case NotificationRoutes.paymentRequestPageRoute:
        notificationTappedCustomPayload =
            PaymentRequestNotificationTapped(route, id, json['paymentId']);
        break;
      case NotificationRoutes.hotelWelcomeRoute:
        notificationTappedCustomPayload =
            HotelWelcomeNotificationTapped(route, id, json['partnerMessageId']);
        break;
      case NotificationRoutes.voucherUsageSuccess:
        notificationTappedCustomPayload = VoucherUsageSuccessTapped(
          route,
          id,
          json['parentName'],
          json['voucherShortCode'],
        );
        break;
      default:
        notificationTappedCustomPayload = NotificationTappedCustomPayload(
          route,
          id,
        );
    }
  }

//TODO: Delete. This is mock for NotificationMessage model
  Map<String, dynamic> toJson() => {};

  NotificationTappedCustomPayload notificationTappedCustomPayload;
}

class NotificationTappedCustomPayload {
  NotificationTappedCustomPayload(this.route, this.messageGroupId);

  final String route;
  final String messageGroupId;
}

class PaymentRequestNotificationTapped extends NotificationTappedCustomPayload {
  PaymentRequestNotificationTapped(
    String route,
    String messageGroupId,
    this.paymentId,
  ) : super(route, messageGroupId);
  final String paymentId;
}

class HotelWelcomeNotificationTapped extends NotificationTappedCustomPayload {
  HotelWelcomeNotificationTapped(
    String route,
    String messageGroupId,
    this.partnerMessageId,
  ) : super(route, messageGroupId);
  final String partnerMessageId;
}

class VoucherUsageSuccessTapped extends NotificationTappedCustomPayload {
  VoucherUsageSuccessTapped(
    String route,
    String messageGroupId,
    this.partnerName,
    this.voucherShortCode,
  ) : super(route, messageGroupId);
  final String partnerName;
  final String voucherShortCode;
}
