import 'package:flutter/material.dart';
import 'package:hackathon/services/notification_service.dart';

class CustomAppBarMobile extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBarMobile()
      : preferredSize = Size.fromHeight(60.0),
        super();

  @override
  final Size preferredSize;

  @override
  _CustomAppBarMobileState createState() => _CustomAppBarMobileState();
}

class _CustomAppBarMobileState extends State<CustomAppBarMobile> {
  bool _nouvelleNotif = false;
  @override
  initState() {
    super.initState();
    Future<NotificationService> notif = NotificationService.instance;
    notif.then((value) => value.onNotification((p0) {
          setState() {
            _nouvelleNotif = true;
          }
        }));
  }

  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Bienvenue sur Transmusicale'),
      actions: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(_nouvelleNotif
                ? Icons.notification_add
                : Icons.notifications_off),
            onPressed: () {
              setState(() {
                selected = !selected;
              });
            },
          ),
        ),
      ],
    );
  }
}
