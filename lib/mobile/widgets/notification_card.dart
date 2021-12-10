
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {

  final String date;
  final String eventName;
  final Color color;

  const EventCard(
     this.eventName,  this.date, this.color,
      ) ;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        color : widget.color,
        width: 300,
        child: Card(
          elevation: 8,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              print('Card tapped.');
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              children:[
                ListTile(
                  title: Text(widget.eventName +' '+ widget.date ),
                  trailing: Icon(Icons.event),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
