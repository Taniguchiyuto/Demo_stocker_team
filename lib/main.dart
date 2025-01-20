import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './View/MyHomePage/MyHomePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './Model/firestore/firestore_model.dart';
import './ViewModel/MyHomePage/MyHomePage.dart';
import './Model/Stock/stock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
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
      home: const MyHomePage(),
    );
  }
}

//プロバイダー定義
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(); //FirestoreServiceのインスタンスを提供
});

final stockViewModelProvider =
    StateNotifierProvider<StockViewModel, List<Stock>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  const userId = 'hogehoge'; // ユーザーIDを固定
  return StockViewModel(firestoreService, userId);
});
