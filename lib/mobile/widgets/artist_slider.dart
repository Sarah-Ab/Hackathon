import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/dao/artiste_dao.dart';
import 'package:hackathon/domain/artiste.dart';
import 'event_card.dart';
import 'artist_card.dart';

class ListViewAritistSlider extends StatefulWidget {
  const ListViewAritistSlider({Key? key}) : super(key: key);

  @override
  _ListViewAritistSliderState createState() => _ListViewAritistSliderState();
}

class _ListViewAritistSliderState extends State<ListViewAritistSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height:  MediaQuery.of(context).size.height,
      child : FutureBuilder(
        future: ArtisteDao.instance.tous(),
        // le texte disparait, c'est à revoir !!!!
        builder: (BuildContext context, AsyncSnapshot<List> artistSnap) => !artistSnap.hasData?
        Center(
          child: Column(
            children:[
              CircularProgressIndicator(),
              Text("Aucune édition durant cette période là! Oupsy Covid"),
            ],
          ),
        ):
        ListView.builder(
            itemCount: artistSnap.data!.length,
            itemBuilder: (BuildContext context, index) =>
                ArtistCard(artiste: (artistSnap.data!.elementAt(index) as Artiste)),
        ),
      ),

    );
  }
}
