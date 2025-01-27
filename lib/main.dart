import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // 日付フォーマット用
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //Firestoreをインポート

import './View/MyHomePage/MyHomePage.dart';
import 'Model/Stock/stocks_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート

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
      home: const HomeScreen(),
    );
  }
}
