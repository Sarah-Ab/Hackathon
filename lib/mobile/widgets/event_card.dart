import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hackathon/mobile/screens/artist_peredition.dart';
//import 'package:spotify_sdk/spotify_sdk.dart';

class EventCard extends StatefulWidget {

  final int annee;
  final String nomEdition;
  final Color couleur;
  //final String imageUrl;

  const EventCard(
     this.annee, this.nomEdition, this.couleur//this.imageUrl
  ) ;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 100,
        width: 100,
        child: Card(
          color: widget.couleur,
          elevation: 8,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtistPerEdition(year: widget.annee)),
              );
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              children:[
                  ListTile(
                    title: Text(widget.annee.toString(), style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: Text(widget.nomEdition,  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
            ],
      ),

            ),
          ),

      );
  }
}
