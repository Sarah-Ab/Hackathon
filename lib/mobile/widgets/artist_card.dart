
import 'package:flutter/material.dart';
import 'package:hackathon/domain/artiste.dart';

import '../mobil_info_artiste.dart';

class ArtistCard extends StatefulWidget {
  final Artiste artiste;
  const ArtistCard({Key? key, required this.artiste}) : super(key: key);



  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        //color : widget.color,
        width: 300,
        child: Card(
          elevation: 8,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoArtiste.artiste(widget.artiste) ,),
              );
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              children:[
                ListTile(
                  title: Text(widget.artiste.nom),
                  trailing: Icon(Icons.person_pin_rounded),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
