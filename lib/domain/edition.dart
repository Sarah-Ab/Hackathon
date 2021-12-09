class Edition {
  static final Map<int, Edition> _editions = {};

  int annee;
  String nom;

  Edition._({required this.annee, required this.nom});

  factory Edition({required int annee, required String nom}) {
    Edition? ed = _editions[annee];
    if (ed != null) {
      return ed;
    } else {
      ed = Edition._(annee: annee, nom: nom);
      _editions[annee] = ed;
      return ed;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is Edition) {
      return annee == other.annee;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => annee.hashCode;

  /// Retourne une chaîne sous la forme "nom (année)".
  @override
  String toString() => "$nom ($annee)";


}
