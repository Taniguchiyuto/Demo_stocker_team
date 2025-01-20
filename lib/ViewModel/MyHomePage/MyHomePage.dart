import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/firestore/firestore_model.dart';
import '../../Model/Stock/stock.dart';

class StockViewModel extends StateNotifier<List<Stock>> {
  final FirestoreService _firestoreService;
  final String userId;
  StockViewModel(this._firestoreService, this.userId) : super([]) {
    // 初期化時にデータを取得
    fetchStocksFromFirestore();
  }
  // Firestoreからデータを取得して状態を更新
  Future<void> fetchStocksFromFirestore() async {
    try {
      final fetchedStocks = await _firestoreService.fetchStocks(userId);
      state = fetchedStocks; // 状態を更新
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreにデータを追加して状態を更新
  Future<void> addStock(String text, DateTime createdAt) async {
    try {
      final documentId =
          await _firestoreService.addStock(userId, text, createdAt);
      final newStock = Stock(id: documentId, text: text, createdAt: createdAt);

      state = [...state, newStock]; // 状態を更新
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

// Firestoreのデータを更新して状態を更新
  Future<void> updateStock(
      String documentId, String text, DateTime createdAt) async {
    try {
      await _firestoreService.updateStock(userId, documentId, text, createdAt);

      state = state.map((stock) {
        if (stock.id == documentId) {
          return Stock(id: documentId, text: text, createdAt: createdAt);
        }
        return stock;
      }).toList(); // 状態を更新
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreのデータを削除して状態を更新
  Future<void> deleteStock(String documentId) async {
    try {
      await _firestoreService.deleteStock(userId, documentId);

      state = state.where((stock) => stock.id != documentId).toList(); // 状態を更新
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
