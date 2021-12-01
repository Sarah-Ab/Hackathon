import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Service de réception des notifications.
class NotificationService {
  static final NotificationService _instance = NotificationService._();
  final FirebaseMessaging _service = FirebaseMessaging.instance;
  bool _isAutorise = false;

  NotificationService._();

  /// Retourne le service de notification.
  ///
  /// Sur certaines plateformes (web notamment), l'utilisateur doit accorder la
  /// permission à l'application avant que le future soit complété.
  static Future<NotificationService> get instance async =>
      _instance._ensureInitialized();

  /// Vrai si les notifications ont été autorisées par l'utilisateur.
  bool get isAutorise => _isAutorise;

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
    }
    return this;
  }
}

class _TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<_TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: NotificationService.instance,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      "Autorisé : ${(snapshot.data as NotificationService).isAutorise}");
                } else if (snapshot.hasError) {
                  return Text((snapshot.error as FirebaseException).toString());
                } else {
                  return const Text("attente");
                }
              },
            ),
            _Message(stream: FirebaseMessaging.onMessage),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatefulWidget {
  final Stream<RemoteMessage> stream;

  const _Message({required this.stream, Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<_Message> {
  RemoteMessage? _message;
  @override
  Widget build(BuildContext context) {
    widget.stream.listen((message) {
      setState(() {
        _message = message;
      });
    });
    if (_message != null) {
      return Text("Data: ${_message!.data}, notif: ${_message!.notification}");
    } else {
      return const Text("Attente messages");
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(_TestApp());
}
