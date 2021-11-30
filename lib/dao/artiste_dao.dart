import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
      FirebaseDatabase.instance.reference().child("artists");

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
  Future<void> sauvegarder(Artiste artiste) async {
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
}

class _AppTest extends StatefulWidget {
  @override
  _AppTestState createState() => _AppTestState();
}

class _AppTestState extends State<_AppTest> {
  String _id = "0";
  bool _updating = false;

  Future<void> _update() async {
    Artiste artiste = Artiste(
      nom: "Kanye West",
      edition: Edition(annee: 2023, nom: "Édition 2023 sur Fortnite"),
      projets: [
        Projet(date: DateTime.now(), salle: "Accor Hotel Arena (Quimper)"),
      ],
      pays: [
        Pays(fr: "France"),
      ],
    );
    await ArtisteDao.instance.sauvegarder(artiste);
    setState(() {
      _id = artiste.id!;
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
