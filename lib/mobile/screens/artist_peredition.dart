import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/dao/artiste_dao.dart';
import 'package:hackathon/domain/artiste.dart';
import 'package:hackathon/mobile/widgets/artist_card.dart';


class ArtistPerEdition extends StatefulWidget {
  final int year;

  const ArtistPerEdition({Key? key, required this.year}) : super(key: key);


  @override
  _ArtistPerEditionState createState() => _ArtistPerEditionState();
}

class _ArtistPerEditionState extends State<ArtistPerEdition> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder(
        future: ArtisteDao.instance.parAnnee(widget.year),
        // TODO le texte disparait, c'est à revoir !!!!
        builder: (BuildContext context, AsyncSnapshot<List> artistSnap) => !artistSnap.hasData?
        Center(
          child: Column(
            children:[
              CircularProgressIndicator(),
              Text("Aucun artiste à cette édition"),
            ],
          ),
        ):
          ListView.builder(
            itemCount : artistSnap.data!.length ,
            itemBuilder: (BuildContext context, index) => ArtistCard(artiste: (artistSnap.data!.elementAt(index)as Artiste)),
          ),
          ),

    );
  }
}
