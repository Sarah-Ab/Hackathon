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
   notify(bool select){
     Future<NotificationService> notif = NotificationService.instance;
     var displayicon;
     displayicon = selected ? Icons.notifications_active: Icons.notifications_off ;
     notif.then((value) => value.onNotification((p0) { displayicon = Icons.notification_important_rounded;}) );
     return displayicon;
  }
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        title: Text('Bienvenue sur Transmusicale'),
         actions:[
           Container(
             padding: const EdgeInsets.all(8.0),
             child: IconButton(
               
                icon: Icon(notify(selected)),
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
