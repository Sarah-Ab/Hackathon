class Pays {
  /// Ensemble des pays classés par [fr].
  static final Map<String, Pays> _pays = {};
  String fr;
  String? en;
  String? onu;
  String? sp;
  String? troisLettres;
  String? deuxLettres;

  /// Constructeur privé pour un pays.
  Pays._({required this.fr});

  /// Retourne un [Pays] correspondant aux informations données.
  factory Pays(
      {required String fr,
      String? en,
      String? onu,
      String? sp,
      String? troisLettres,
      String? deuxLettres}) {
    Pays pays = _pays[fr] ?? Pays._(fr: fr);
    pays.en ??= en;
    pays.onu ??= onu;
    pays.sp ??= sp;
    pays.troisLettres ??= troisLettres;
    pays.deuxLettres ??= deuxLettres;
    _pays[fr] = pays;
    return pays;
  }

  /// Retourne tous les pays présents en mémoire.
  static Iterable<Pays> get tous => _pays.values;

  @override
  bool operator ==(Object other) {
    if (other is Pays) {
      return fr == other.fr;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => fr.hashCode;
}
