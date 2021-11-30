import 'dart:ui';

import 'package:hackathon/domain/edition.dart';
import 'package:hackathon/domain/projet.dart';
import 'package:hackathon/domain/pays.dart';

class Artiste {
  /// Id de l'artiste dans la base de données. Null s'il l'artiste n'est pas
  /// dans la base.
  int? id;
  String nom;
  Edition? edition;
  List<Projet> projets;
  String? spotify;
  String? deezer;
  Locale? langue;
  List<Pays> pays;

  Artiste({
    this.id,
    required this.nom,
    required this.edition,
    required this.projets,
    this.spotify,
    this.deezer,
    required this.pays,
    this.langue,
  });

  /// Crée un [Artiste] depuis une [map] parsée du JSON stocké dans la base de
  /// donnée.
  ///
  /// La [map] contient un champs "fields" contenant les champs.
  factory Artiste.fromJSON(Map<dynamic, dynamic> map, {required int id}) {
    Map<dynamic, dynamic> fields = map["fields"];
    List<Projet> projets = [];
    for (int i = 1; i <= 6; i++) {
      String ieme = i == 1 ? "1ere" : "${i}eme";
      String kProjet = i == 1 ? "1er_projet_atm" : "${ieme}_projet";
      String kDateTimestamp = "${ieme}_date_timestamp";
      String kSalle = "${ieme}_salle";
      if (fields[kDateTimestamp] == null) {
        break;
      }
      projets.add(Projet(
        nom: fields[kProjet],
        date:
            DateTime.fromMillisecondsSinceEpoch(fields[kDateTimestamp] * 1000),
        salle: fields[kSalle],
      ));
    }
    List<Pays> pays = [];
    for (int i = 1; i <= 4; i++) {
      String? originePays = fields["origine_pays$i"];
      if (originePays == null) {
        break;
      } else if (i == 1) {
        pays.add(Pays(
          fr: originePays,
          en: fields["cou_text_en"],
          sp: fields["cou_text_sp"],
          onu: fields["cou_onu_code"],
          troisLettres: fields["cou_iso3_code"],
          deuxLettres: fields["cou_iso2_code"],
        ));
      }
    }
    return Artiste(
      id: id,
      nom: fields["artistes"],
      edition: fields["edition"] != null
          ? Edition(
              annee: int.parse(fields["annee"]),
              nom: fields["edition"],
            )
          : null,
      projets: projets,
      pays: pays,
      spotify: fields["spotify"],
      deezer: fields["deezer"],
      langue: fields["cou_official_lang_code"] != null
          ? Locale(fields["cou_official_lang_code"])
          : null,
    );
  }

  /// Retourne une chaîne sous la forme "nom (id), édition".
  @override
  String toString() =>
      nom +
      (id != null ? " ($id)" : "") +
      (edition != null ? ", $edition" : "");
}
