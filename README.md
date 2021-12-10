# hackathon

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Clé de serveur Firebase Cloud Messaging

Si ce message s'affiche à la compilation

```
No file or variants found for asset: asset/fcm.json.
```

- Copier [`asset/fcm-EXEMPLE.json`](asset/fcm-EXEMPLE.json) dans
  `asset/fcm.json`
- Optionnel (pour pouvoir utiliser
  [`NotificationSender`](lib/services/notification_sender.dart)) : remplacer
  `CLE_SERVEUR` dans `asset/fcm.json` par le jeton de clé présent sur
  https://console.firebase.google.com/project/transmusicales-baa67/settings/cloudmessaging/android:fr.istic.e.hackathon.
