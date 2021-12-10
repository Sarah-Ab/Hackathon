import 'package:database/database.dart';
import 'package:hackathon/dao/artiste_dao.dart';
import 'package:search/search.dart';

void main() async {
  // Set default database
  final database = SearcheableDatabase(
    master: MemoryDatabaseAdapter(),
    isReadOnly: true,
  ).database();

  // Search items
  final collection = ArtisteDao.instance.m;
  final response = await collection.search(
    query: Query.parse('"software developer" (dart OR javascript)'),
  );

  // Print items
  for (var snapshot in response.snapshots) {
    print('Document ID: ${snapshot.document.documentId}');
  }
}