# hackathon

Projet réalisé avec Flutter et Firebase

## Comment lancer les différentes versions
Pour lancer la partie web, il faut lancer le fichier "main.dart" sur un navigateur.

Pour lancer la partie android, il faut exécuté "welcome_pagemobile.dart" qui se trouve dans le dossier "/mobile/screens" avec soi émulateur android, soit avec son téléphone personnel.

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
