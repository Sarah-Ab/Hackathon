import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/domain/artiste.dart';
import 'package:hackathon/domain/edition.dart';
import 'package:hackathon/domain/pays.dart';
import 'package:hackathon/domain/projet.dart';

/// Objet d'accès aux artistes présents dans la base de données.
class ArtisteDao {
  /// Instance du DAO.
  static final ArtisteDao instance = ArtisteDao._();
  final DatabaseReference _db =
      FirebaseDatabase.instance.reference().child("artistes");
  final List<Artiste> _jsonArtistes = [];

  ArtisteDao._();

  /// Retourne l'artiste d'[id] donné.
  Future<Artiste?> parRecordId(String id) async {
    DatabaseReference loc = _db.child(id);
    dynamic res = (await loc.get()).value;
    Artiste? artiste = res != null ? Artiste.fromJSON(res, id: id) : null;
    loc.onValue.listen(artiste?.updateListener);
    return artiste;
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
    if (artiste.id != null) {
      DatabaseReference loc = _db.child(artiste.id!);
      await loc.set(artiste.toMap());
    } else {
      DatabaseReference loc = _db.push();
      artiste.id = loc.key;
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
    if (artiste.id != null) {
      await _db.child(artiste.id!).remove();
    }
  }

  /// Retourne tous les artistes ayant participé l'[annee] donnée.
  Future<List<Artiste>> parAnnee(int annee) async {
    Edition edition = Edition(annee: annee, nom: "Édition $annee");
    return List.from([1, 2, 3, 4].map((i) =>
        Artiste(nom: "Artiste $i", projets: [], pays: [], edition: edition)));
  }

  /// S'assure que les données ont été initalisées avant manipulation.
  Future<void> _ensureInitialized() async {
    if (_jsonArtistes.isEmpty) {
      String json = await rootBundle.loadString("asset/dataset-Lite");
    }
  }
}

class _AppTest extends StatefulWidget {
  @override
  _AppTestState createState() => _AppTestState();
}

class _AppTestState extends State<_AppTest> {
  String _id = "0";
  bool _updating = false;
  Artiste? _artiste;

  Future<void> _update() async {
    _artiste = Artiste(
      nom: "Kanye West",
      edition: Edition(annee: 2023, nom: "Édition 2023 sur Fortnite"),
      projets: [
        Projet(date: DateTime.now(), salle: "Accor Hotel Arena (Quimper)"),
      ],
      pays: [
        Pays(fr: "France"),
      ],
    );
    await ArtisteDao.instance.sauvegarder(_artiste!);
    setState(() {
      _id = _artiste!.id!;
      _updating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(children: [
            FutureBuilder(
              future: ArtisteDao.instance.parRecordId(_id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  (snapshot.data as Artiste).onUpdate(() => setState(() {}));
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  throw snapshot.error!;
                } else {
                  return const Text("waiting");
                }
              },
            ),
            TextButton(
              child: const Text("nouvel artiste"),
              onPressed: _updating
                  ? null
                  : () {
                      setState(() {
                        _updating = true;
                      });
                      _update();
                    },
            ),
            TextButton(
              onPressed: _updating || _artiste == null
                  ? null
                  : () {
                      setState(() {
                        _updating = true;
                        ArtisteDao.instance.supprimer(_artiste!);
                        _artiste = null;
                      });
                    },
              child: const Text("supprimer"),
            ),
          ], mainAxisAlignment: MainAxisAlignment.center),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(_AppTest());
}
