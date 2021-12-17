import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/domain/artiste.dart';
import 'package:hackathon/domain/edition.dart';
import 'package:hackathon/domain/pays.dart';
import 'package:hackathon/domain/projet.dart';
import 'package:string_similarity/string_similarity.dart';

/// Objet d'accès aux artistes présents dans la base de données.
class ArtisteDao {
  /// Instance du DAO.
  static final ArtisteDao instance = ArtisteDao._();
  final DatabaseReference _db =
      FirebaseDatabase.instance.reference().child("artistes");
  final Map<String, Artiste> _jsonArtistes = {};

  ArtisteDao._();

  /// Retourne tous les artistes.
  Future<List<Artiste>> tous() async {
    await _ensureInitialized();
    Iterable<dynamic> dbArtistes = (await _db.get()).value?.values ?? [];
    return List<Artiste>.from(_jsonArtistes.values) +
        List<Artiste>.from(
            dbArtistes.map<Artiste>((map) => Artiste.fromJSON(map)));
  }

  /// Retourne l'artiste de [recordid] donné.
  Future<Artiste?> parRecordId(String recordid) async {
    await _ensureInitialized();
    Artiste? artiste = _jsonArtistes[recordid];
    if (artiste != null) {
      return artiste;
    } else {
      DatabaseReference loc = _db.child(recordid);
      dynamic res = (await loc.get()).value;
      artiste = res != null ? Artiste.fromJSON(res) : null;
      loc.onValue.listen(artiste?.updateListener);
      return artiste;
    }
  }

  /// Sauvegarde l'[artiste] donné dans la base.
  ///
  /// Les artistes ayant participé à des éditions antérieures à 2021 ne peuvent
  /// pas être sauvegardés.
  Future<void> sauvegarder(Artiste artiste) async {
    if ((artiste.edition?.annee ?? 0) < 2021) {
      throw Exception(
          "Les artistes ayant participé à une édition antérieure à 2021 ne "
          "peuvent pas être modifiés");
    }
    if (artiste.recordid != null) {
      DatabaseReference loc = _db.child(artiste.recordid!);
      await loc.set(artiste.toMap());
    } else {
      DatabaseReference loc = _db.push();
      artiste.recordid = loc.key;
      await loc.set(artiste.toMap());
      loc.onValue.listen(artiste.updateListener);
    }
  }

  /// Supprime l'[artiste] donné de la base.
  ///
  /// Les artistes ayant participé à des éditions antérieures à 2021 ne peuvent
  /// pas être sauvegardés.
  Future<void> supprimer(Artiste artiste) async {
    if ((artiste.edition?.annee ?? 0) < 2021) {
      throw Exception(
          "Les artistes ayant participé à une édition antérieure à 2021 ne "
          "peuvent pas être supprimés");
    }
    if (artiste.recordid != null) {
      await _db.child(artiste.recordid!).remove();
    }
  }

  /// Retourne tous les artistes ayant participé l'[annee] donnée.
  Future<List<Artiste>> parAnnee(int annee) async {
    await _ensureInitialized();
    if (annee < 2021) {
      return List.from(_jsonArtistes.values
          .where((artiste) => (artiste.edition?.annee ?? annee + 1) == annee));
    } else {
      Map<dynamic, dynamic>? artistes = (await _db
              .orderByChild("fields/annee")
              .equalTo(annee.toString())
              .once())
          .value;
      if (artistes != null) {
        return List.from(
            artistes.values.map((artiste) => Artiste.fromJSON(artiste)));
      } else {
        return [];
      }
    }
  }

  /// Retourne tous les artistes jouant le [jour] donné.
  Future<Iterable<Artiste>> parJour(DateTime jour) async {
    List<Artiste> annee = await parAnnee(jour.year);
    return annee.where((artiste) => artiste.projets.any((projet) =>
        projet.date.day == jour.day && projet.date.month == jour.month));
  }

  /// Retourne les artistes dont le nom match avec [s].
  Future<List<Artiste>> matchNom(String s) async {
    List<Artiste> artistes = await tous();
    Map<Artiste, num> distances = {};
    artistes.sort((a1, a2) {
      num d1 = distances[a1] ??
          (distances[a1] = StringSimilarity.compareTwoStrings(a1.nom, s));
      num d2 = distances[a2] ??
          (distances[a2] = StringSimilarity.compareTwoStrings(a2.nom, s));
      return d2.compareTo(d1);
    });
    return artistes.where((artiste) => distances[artiste]! > 0).toList();
  }

  /// S'assure que les données ont été initalisées avant manipulation.
  Future<void> _ensureInitialized() async {
    if (_jsonArtistes.isEmpty) {
      String json = await rootBundle.loadString("asset/artistes.json");
      List<dynamic> maps = await compute(_parseArtistes, json);
      for (Map<String, dynamic> map in maps) {
        _jsonArtistes[map["recordid"]] = Artiste.fromJSON(map);
      }
    }
  }

  /// Parse la liste des artistes depuis le [json] dans [dest].
  static List<dynamic> _parseArtistes(String json) {
    return jsonDecode(json);
  }
}
