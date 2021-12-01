importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyDA6G8yE--T6WtloG67XEsP8M2RvoieihI",
    authDomain: "transmusicales-baa67.firebaseapp.com",
    databaseURL: "https://transmusicales-baa67-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "transmusicales-baa67",
    storageBucket: "transmusicales-baa67.appspot.com",
    messagingSenderId: "493207782631",
    appId: "1:493207782631:web:970d20592fa5bd542b0e42"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});