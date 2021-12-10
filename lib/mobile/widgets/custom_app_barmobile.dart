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
                return test(snapshot.data as NotificationService);
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.n.onNotification((p0) {
      setState(() {
        no = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Icon(no? Icons.notification_important_rounded : Icons.ac_unit_outlined);
  }

  }
