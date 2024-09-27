import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nptypush/main.dart'; // Import the main.dart file

class FirebaseApi {
  // Create an instance of Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Firebase app
  Future<void> initNotifications() async {
    // Request permission from the user
    await _firebaseMessaging.requestPermission(
      alert: true,
    );

    // Get the token from Firebase
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('FCM token: $token');
      await initPushNotifications();
    }
  }

  // Function to initialize background settings
  Future<void> initPushNotifications() async {
    // Get the initial message
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Listen for messages when the app is in the foreground
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  // Function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // If the message ID is null, do nothing
    if (message == null) return;

    // Navigate to a new screen when a message is received and the app is in the background
    navigatorKey.currentState?.pushNamed(
      '/notification',
      arguments: message,
    );
  }
}
