/// Une notification, envoyée par l'exploitant et reçue par l'utilisateur.
class NotificationChangement {
  /// Titre de la notification
  String titre;

  /// Corps de la notification
  String corps;

  NotificationChangement({required this.titre, required this.corps});

  @override
  String toString() => "$titre: $corps";
}
