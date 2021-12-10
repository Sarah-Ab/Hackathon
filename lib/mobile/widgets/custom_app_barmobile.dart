import 'package:flutter/material.dart';
import 'package:hackathon/mobile/screens/welcome_pagemobile.dart';
import 'package:hackathon/mobile/widgets/Display_notif.dart';
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
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Bienvenue sur Transmusicale'),

      actions: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: NotificationService.instance,
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return  IconButton(
                  icon:test(snapshot.data as NotificationService),
                    onPressed: () {
                    Display_notif();
                });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("attente");
              }
            },
          )
        ),
      ],
    );
  }
}
  class test extends StatefulWidget{
  NotificationService n;
  test(this.n);
  @override
  State<StatefulWidget> createState() => test0();
  }

  class test0 extends State<test>{
  bool no = false;
  String msg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.n.onNotification((notif) {
      setState(() {
        no = true;
        titremsg.add(notif.titre);
        descmsg.add(notif.corps);
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Icon(no? Icons.notification_important_rounded : Icons.notifications_rounded);
  }

  }
