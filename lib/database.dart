import 'package:firebase_database/firebase_database.dart';

class Database {
  static final instance = Database._();

  final DatabaseReference _ref = FirebaseDatabase.instance.reference();

  Database._();

  Future<dynamic> artist(int id) async {
    return (await _ref.child("artists/$id").get()).value;
  }
}
