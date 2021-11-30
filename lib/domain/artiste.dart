import 'dart:ui';

import 'package:hackathon/domain/edition.dart';
import 'package:hackathon/domain/projet.dart';
import 'package:hackathon/domain/pays.dart';

class Artiste {
  /// Identifiant de l'artiste dans la base. Null si l'artiste n'est pas
  /// enregistré dans la base.
  String? id;
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
  factory Artiste.fromJSON(Map<dynamic, dynamic> map, {required String id}) {
    Map<dynamic, dynamic> fields = map["fields"];
    List<Projet> projets = [];
    for (int i = 1; i <= 6; i++) {
      if (fields[_kDateTimestamp(i)] == null) {
        break;
      }
      projets.add(Projet(
        nom: fields[_kProjet(i)],
        date: DateTime.fromMillisecondsSinceEpoch(
            fields[_kDateTimestamp(i)] * 1000),
        salle: fields[_kSalle(i)],
        ville: fields[_kVille(i)],
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

  /// Retourne une chaîne sous la forme "nom, édition".
  @override
  String toString() => nom + (edition != null ? ", $edition" : "");

  /// Retourne une map afin d'être stockée dans la base de données.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    Map<String, dynamic> fields = (map["fields"] = <String, dynamic>{});
    fields["artistes"] = nom;
    fields["spotify"] = spotify;
    fields["deezer"] = deezer;
    fields["cou_official_lang_code"] = langue?.countryCode?.toUpperCase();
    fields["edition"] = edition?.nom;
    fields["annee"] = edition?.annee.toString();
    projets.asMap().forEach((i, projet) {
      i += 1;
      fields[_kProjet(i)] = projet.nom;
      fields[_kDateTimestamp(i)] = projet.date.millisecondsSinceEpoch ~/ 1000;
      String jour = projet.date.day < 10
          ? "0${projet.date.day}"
          : projet.date.day.toString();
      String mois = <int, String>{
        1: "jan",
        2: "fév",
        3: "mar",
        4: "avr",
        5: "mai",
        6: "jui",
        7: "jui",
        8: "aoû",
        9: "sep",
        10: "oct",
        11: "nov",
        12: "déc",
      }[projet.date.month]!;
      String annee = projet.date.year < 2010
          ? "0${projet.date.year % 2000}"
          : (projet.date.year % 2000).toString();
      fields["${_ieme(i)}_date"] = "$jour-$mois-$annee";
      fields[_kSalle(i)] = projet.salle;
      fields[_kVille(i)] = projet.ville;
    });
    pays.asMap().forEach((i, pays) {
      i += 1;
      fields["origine_pays$i"] = pays.fr;
      if (i == 1) {
        fields["cou_iso2_code"] = pays.deuxLettres;
        fields["cou_iso3_code"] = pays.troisLettres;
        fields["cou_onu_code"] = pays.onu;
        fields["cou_text_en"] = pays.en;
        fields["cou_text_sp"] = pays.sp;
      }
    });
    return map;
  }
}

/// Retourne "1ere", "2eme", "3eme"... en fonction de [i].
String _ieme(int i) => i == 1 ? "1ere" : "${i}eme";

/// Retourne la clef du nom du [i]ème projet dans la table.
String _kProjet(int i) => i == 1 ? "1er_projet_atm" : "${_ieme(i)}_projet";

/// Retourne la clef du timestamp du [i]ème projet dans la table.
String _kDateTimestamp(int i) => "${_ieme(i)}_date_timestamp";

/// Retourne la clef de la salle du [i]ème projet dans la table.
String _kSalle(int i) => "${_ieme(i)}_salle";

/// Retourne la clef de la ville du [i]ème projet dans la table.
String _kVille(int i) => "${_ieme(i)}_ville";
