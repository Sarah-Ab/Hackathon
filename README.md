# hackathon

Projet réalisé avec Flutter et Firebase

## Comment lancer les différentes versions
Pour lancer la partie web:
- Depuis Android Studio, il faut lancer le fichier "main.dart" sur un navigateur.
- Avec la commande : `flutter run -d chrome -t lib/main.dart`

Pour lancer la partie android :
- Depuis Android Studio, il faut exécuter "welcome_pagemobile.dart" qui se trouve dans le dossier "/mobile/screens" avec soit émulateur android, soit avec son téléphone personnel.
- Avec la commande : `flutter run -t lib/mobile/screens/welcome_pagemobile.dart`

## Clé de serveur Firebase Cloud Messaging

Si ce message s'affiche à la compilation

```
No file or variants found for asset: asset/fcm.json.
```

- Copier [`asset/fcm-EXEMPLE.json`](asset/fcm.json) dans
  `asset/fcm.json`
- Optionnel (pour pouvoir utiliser
  [`NotificationSender`](lib/services/notification_sender.dart)) : remplacer
  `CLE_SERVEUR` dans `asset/fcm.json` par le jeton de clé présent sur
  https://console.firebase.google.com/project/transmusicales-baa67/settings/cloudmessaging/android:fr.istic.e.hackathon.
