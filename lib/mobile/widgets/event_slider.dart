import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/dao/edition_dao.dart';
import 'package:spotify_sdk/spotify_sdk.dart';


import 'event_card.dart';

class ListViewEventSlider extends StatefulWidget {
  const ListViewEventSlider({Key? key}) : super(key: key);


  @override
  _ListViewEventSliderState createState() => _ListViewEventSliderState();
}

class _ListViewEventSliderState extends State<ListViewEventSlider> {

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(8),
      height: 300,
      child: FutureBuilder(
              future: EditionDao.instance.parAnnees(2015,2021),
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
                itemCount: editionSnap.data!.length > 10 ? 10 : editionSnap.data!.length ,
                itemBuilder: (BuildContext context, index) =>
                    EventCard(editionSnap.data![index].annee.toString(), editionSnap.data![index].nom,Colors.primaries[Random().nextInt(Colors.primaries.length)]),
              ),
             ),
    );
  }
}
