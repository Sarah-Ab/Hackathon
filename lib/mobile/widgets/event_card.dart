import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class EventCard extends StatefulWidget {

  final String date;
  final String artistName;
  final Color color;
  //final String imageUrl;

  const EventCard(
     this.date, this.artistName, this.color//this.imageUrl
  ) ;




  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        //height: 300,
        width: 300,
        child: Card(
          color: widget.color,
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
                    title: Text(widget.date),
                    subtitle: Text(widget.artistName),
                  ),
              Container(
                height:200,
                width:250,
                child:Image.network('spotify:album:1sWIbvCurzF7ZVFYWjLGQO',fit: BoxFit.fill, alignment: Alignment.center),

              )
            ],
      ),


            ),
          ),

      );
  }
}
