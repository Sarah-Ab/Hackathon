import 'package:hackathon/edition.dart';

class Artiste {
  String nom;
  Edition edition;
  String? spotify;
  String? deezer;

  Artiste(
      {required this.nom, required this.edition, this.spotify, this.deezer});
}
