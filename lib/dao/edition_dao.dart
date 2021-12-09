import 'package:hackathon/dao/artiste_dao.dart';
import 'package:hackathon/domain/artiste.dart';
import 'package:hackathon/domain/edition.dart';

class EditionDao {
  Future<Edition?> parAnnee(int annee) async {
    List<Artiste> artistes = await ArtisteDao.instance.parAnnee(annee);
    return artistes.isEmpty ? null : artistes.first.edition!;
  }

  Future<List<Edition>> parAnnees(int from, int to) async {
    List<Edition> editions = [];
    for (var i = from; i < to; i++) {
      Edition? edition = await parAnnee(i);
      if (edition != null) editions.add(edition);
    }
    return editions;
  }
}
