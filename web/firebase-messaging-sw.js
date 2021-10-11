importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyBgAsVroyKItF7yFDJz_W3v-rMv7b264lM",
    authDomain: "critt-f0fb7.firebaseapp.com",
    databaseURL: "https://critt-f0fb7.firebaseio.com",
    projectId: "critt-f0fb7",
    storageBucket: "critt-f0fb7.appspot.com",
    messagingSenderId: "976072875785",
    appId: "1:976072875785:web:79c2f17fe5dffc89ff7dd8",
    measurementId: "G-NN8FQ4E4K4"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});