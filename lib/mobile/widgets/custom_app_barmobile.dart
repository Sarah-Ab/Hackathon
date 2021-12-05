import 'package:flutter/material.dart';

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
                icon: Icon( selected ? Icons.notifications_active: Icons.notifications_off),
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
