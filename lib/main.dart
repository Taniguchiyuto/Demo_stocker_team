import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import './View/MyHomePage/MyHomePage.dart';
import 'View/bottom_nav_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import './View/bottom_nav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      // ProviderScopeでアプリをラップ
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Header Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavScreen(),
    );
  }
}
