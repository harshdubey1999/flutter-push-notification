import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nptypush/api/firebase_api.dart';
import 'package:nptypush/firebase_options.dart';
import 'package:nptypush/home_page.dart';
import 'package:nptypush/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine the appropriate Firebase options based on the platform
  FirebaseOptions firebaseOptions;
  if (Platform.isLinux || Platform.isWindows) {
    firebaseOptions = DefaultFirebaseOptions.web;
  } else {
    firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  }

  // Initialize Firebase with the correct options
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification': (context) => const NotificationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
