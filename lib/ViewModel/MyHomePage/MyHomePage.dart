import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/firestore/firestore_model.dart';
import '../../Model/Stock/stock.dart';
import 'my_home_state.dart';

final myHomeProvider = StateNotifierProvider<MyHomeViewModel, MyHomeState>(
  (ref) => MyHomeViewModel(),
);

class MyHomeViewModel extends StateNotifier<MyHomeState> {
  final FirestoreService _firestoreService = FirestoreService();

  MyHomeViewModel()
      : super(
          const MyHomeState(
            savedItems: [],
            userId: 'hogehoge',
          ),
        ) {
    listenToStocks();
  }

  // Firestoreから
  Future<void> listenToStocks() async {
    try {
      final stockStream = await _firestoreService.streamStocks(state.userId);
      stockStream.listen((stocks) {
        state = state.copyWith(savedItems: stocks);
      });
      print('Firestoreからデータを取得しました');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreの既存ドキュメントを更新
  Future<void> updateStock(int index, String text, DateTime createdAt) async {
    final stock = state.savedItems[index];
    final documentId = stock.id;
    if (documentId == null) {
      print("エラー: ドキュメントIDがnullのため更新できません");
      return;
    }
    try {
      await _firestoreService.updateStock(
          state.userId, documentId, text, createdAt);
      final newStock = Stock(id: documentId, text: text, createdAt: createdAt);
      final newList = [...state.savedItems];
      newList[index] = newStock;
      state = state.copyWith(savedItems: newList);
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreのドキュメント削除
  Future<void> deleteStock(int index) async {
    final stock = state.savedItems[index];
    final documentId = stock.id;
    if (documentId == null) {
      print('エラー: ドキュメントIDがnullのため削除できません');
      return;
    }
    try {
      await _firestoreService.deleteStock(state.userId, documentId);
      final newList = [...state.savedItems]..removeAt(index);
      state = state.copyWith(savedItems: newList);
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
