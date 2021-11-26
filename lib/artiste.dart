import 'package:hackathon/edition.dart';
import 'package:hackathon/projet.dart';

class Artiste {
  String nom;
  Edition edition;
  List<Projet> projets;
  String? spotify;
  String? deezer;

  Artiste(
      {required this.nom,
      required this.edition,
      required this.projets,
      this.spotify,
      this.deezer});
}
