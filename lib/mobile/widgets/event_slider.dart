import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/dao/edition_dao.dart';
//import 'package:spotify_sdk/spotify_sdk.dart';


import 'event_card.dart';

class ListViewEventSlider extends StatefulWidget {
  final int? limiteAffichage;
  final int anneeDebut;
  final int anneeFin;
  const ListViewEventSlider( {Key? key, this.limiteAffichage, required this.anneeDebut, required this.anneeFin}) : super(key: key);


  @override
  _ListViewEventSliderState createState() => _ListViewEventSliderState();
}

class _ListViewEventSliderState extends State<ListViewEventSlider> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height:  MediaQuery.of(context).size.height,
      child: FutureBuilder(
              future: EditionDao.instance.parAnnees(widget.anneeDebut,widget.anneeFin),
              // le texte disparait, c'est à revoir !!!!
              builder: (BuildContext context, AsyncSnapshot<List> editionSnap) => !editionSnap.hasData?
              Center(
                child: Column(
                  children:[
                    CircularProgressIndicator(),
                    Text("Aucune édition durant cette période là! Oupsy Covid"),
                  ],
                ),
              ):
              ListView.builder(
                itemCount: editionSnap.data!.length > widget.limiteAffichage! ? widget.limiteAffichage! : editionSnap.data!.length ,
                itemBuilder: (BuildContext context, index) =>
                    EventCard(editionSnap.data![index].annee, editionSnap.data![index].nom,Colors.primaries[Random().nextInt(Colors.primaries.length)]),
              ),
             ),
    );
  }
}
