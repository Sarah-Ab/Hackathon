import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/domain/notification.dart';

/// Service de réception des notifications.
class NotificationService {
  static const String topicName = "changements";
  static final NotificationService _instance = NotificationService._();
  final FirebaseMessaging _service = FirebaseMessaging.instance;
  bool _isAutorise = false;
  final List<void Function(NotificationChangement)> _onNotif = [];

  NotificationService._();

  /// Retourne le service de notification.
  ///
  /// Sur certaines plateformes (web notamment), l'utilisateur doit accorder la
  /// permission à l'application avant que le future soit complété.
  static Future<NotificationService> get instance async =>
      _instance._ensureInitialized();

  /// Vrai si les notifications ont été autorisées par l'utilisateur.
  bool get isAutorise => _isAutorise;

  /// Appelle [callback] lorsqu'une notification est reçue alors que
  /// l'application est au premier plan (ne marche pas pour les notifications
  /// reçues en arrière plan).
  void onNotification(void Function(NotificationChangement) callback) {
    _onNotif.add(callback);
  }

  Future<NotificationService> _ensureInitialized() async {
    if (!_isAutorise) {
      NotificationSettings settings = await _service.requestPermission();
      _isAutorise =
          settings.authorizationStatus == AuthorizationStatus.authorized;
      if (isAutorise) {
        await _service.getToken(
            vapidKey:
                "BKiAeHvD-b5ea3LvOX7gp9XBE8rMDGUZiAUZ8jv9d4l6-ECv-A-pAGlxdHAnk1h3KCV8jrk4ywsvU8hWOgXubks");
      }
      if (!kIsWeb) {
        await _service.subscribeToTopic(topicName);
      }
      FirebaseMessaging.onMessage.listen((message) {
        if (message.notification != null) {
          NotificationChangement notification = NotificationChangement(
            titre: message.notification!.title ?? "(Sans titre)",
            corps: message.notification!.body ?? "(Sans corps)",
          );
          for (var callback in _onNotif) {
            callback(notification);
          }
        }
      });
    }
    return this;
  }
}
