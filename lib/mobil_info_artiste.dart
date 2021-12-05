import 'package:flutter/material.dart';
import 'package:hackathon/dao/artiste_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackathon/domain/artiste.dart';

import 'ColorCustom.dart';

void main() async {
  runApp(infoArtiste("i"));
}

class info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    throw UnimplementedError();
  }
}

class infoArtiste extends StatelessWidget {
  infoArtiste(this.id, {Key? key}) : super(key: key) {
    ar = ArtisteDao.instance.parRecordId(id!);
    ar!.then((value) => init(value!)).catchError((e) => error(e));
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

  Widget getInfo() {
    return ListView(
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
          body: Center(
            child: ((this.errorD.isEmpty ? Text("True") : getInfo())),
          ),
        ));
  }
}
