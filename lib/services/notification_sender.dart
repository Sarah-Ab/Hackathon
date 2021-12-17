import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/domain/notification.dart';
import 'package:hackathon/services/notification_service.dart';

/// Service d'envoie de notifications.
class NotificationSender {
  /// Instance du service
  static final NotificationSender instance = NotificationSender._();

  /// Clé de serveur de Firebase Cloud Messaging
  String? _key;

  /// Crée un service d'envoie de notifications avec la clé de serveur Firebase
  /// Cloud Messaging [key].
  NotificationSender._();

  /// Envoie la [notification] aux clients.
  Future<void> envoyer(NotificationChangement notification) async {
    await _ensureInitialized();
    http.Response response =
        await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Authorization": "key=${_key!}",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "to": "/topics/${NotificationService.topicName}",
              "notification": {
                "sound": "default",
                "body": notification.corps,
                "title": notification.titre,
                "content_available": true,
                "priority": "high"
              }
            }));

    if (response.statusCode < 400) {
      return;
    } else {
      throw Exception(response.body.toString());
    }
  }

  /// S'assure que le service est initialisé.
  Future<void> _ensureInitialized() async {
    if (_key == null) {
      String json = await rootBundle.loadString("asset/fcm.json");
      Map<String, dynamic> map = jsonDecode(json);
      _key = map["cle_serveur"];
    }
  }
}
