import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/dao/artiste_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackathon/domain/artiste.dart';

import 'ColorCustom.dart';

void main() async {
  runApp(InfoAr("i"));
}

class InfoAr extends StatefulWidget {
  InfoAr( this.id, {Key? key}) : super(key: key);
  String? id;
  @override
  State<StatefulWidget> createState() => InfoArtiste(id);
}

class InfoArtiste extends State<InfoAr> {
  InfoArtiste(this.id) {
    //ar = ArtisteDao.instance.parRecordId(id!);
    testinitinfo();
    //ar!.then((value) => init(value!)).catchError((e) => error(e));
  }

  String? id;
  Future<Artiste?>? ar;
  String? nom;
  String? langue;
  String? pays;
  String? edition;

  String? deezer;
  String? spotify;
  String errorD = '';

  void init(Artiste a) {
    langue = a.langue.toString();
    pays = a.pays.toString();
    edition = a.edition.toString();
    nom = a.nom.toString();
    deezer = a.deezer.toString();
    spotify = a.spotify.toString();
  }

  void error(ErrorDescription e) {
    print(e);
    errorD = e.toString();
  }
  void testinitinfo(){
    langue = "fr";
    pays = "france";
    edition = "ed1";
    nom = "jean";
    deezer = "deezer";
    spotify = "spo";
    errorD ='';
  }
  Widget cond(){
    return (this.errorD.isEmpty ? getInfo() : Text("True"));
  }
  Widget getInfo() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          child: Column(
            children: [
              Text('nom'),
              Text(nom!),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('pays'),
              Text(pays!),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('langue'),
              Text(langue!),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('edition'),
              Text(edition!),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('deezer'),
              Text(deezer!),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Text('spotify'),
              Text(spotify!),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: colorCustom,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('info'),
          ),
          body: Container(

            child: cond(),
    )
        )
        );
  }
}
