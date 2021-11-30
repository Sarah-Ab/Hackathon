import 'package:flutter/cupertino.dart';
import 'package:hackathon/edition.dart';
import 'package:hackathon/projet.dart';
import 'package:hackathon/pays.dart';
class Artiste {
  String nom;
  Edition edition;
  List<Projet> projets;
  String? spotify;
  String? deezer;
  Locale? langue;
  Pays? pays;

  Artiste(
      {required this.nom,
      required this.edition,
      required this.projets,
      this.spotify,
      this.deezer});
}
