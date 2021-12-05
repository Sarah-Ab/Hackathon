
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {

  final String date;
  final String eventName;
  final String smallDescription;

  const EventCard(
     this.eventName,  this.date, this.smallDescription
      ) ;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
                  subtitle: Text(widget.smallDescription),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
