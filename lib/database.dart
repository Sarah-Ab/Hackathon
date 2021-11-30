import 'package:firebase_database/firebase_database.dart';
import 'package:hackathon/artiste.dart';

class Database {
  static final instance = Database._();

  final DatabaseReference _ref = FirebaseDatabase.instance.reference();

  Database._();

  Future<Artiste> artist(int id) async {
    return Artiste.fromJSON((await _ref.child("artists/$id").get()).value);
  }

  Future<Iterable<Artiste>> artistes() async {
    return ((await _ref.child("artists").get()).value as List<dynamic>)
        .map((map) => Artiste.fromJSON(map));
  }
}
