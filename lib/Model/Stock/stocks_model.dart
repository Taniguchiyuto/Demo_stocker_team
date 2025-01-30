import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firestore/firestore_model.dart';
import 'stocks.dart';
// import 'stock.dart';
import 'stock.dart';

final StocksModelProvider =
    StateNotifierProvider<StocksModel, Stocks>((ref) => StocksModel(ref));

class StocksModel extends StateNotifier<Stocks> {
  // final FirestoreService _firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Ref ref;

  StocksModel(this.ref) : super(Stocks()) {
    () async {
      await streamStocks();
    }();
  }

  Future<void> streamStocks() async {
    try {
      final streamStocks = await ref.read(StocksReposi).streamStocks();
      streamStocks.listen((stocks) {
        state = state.copyWith(stocks: stocks);
      });
    } on Exception catch (e) {
      print('streamStocks error: $e');
    }
  }

  Future<String> addStock(String text, DateTime createdAt) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc("hogehoge")
          .collection('stocks')
          .add({
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      });
      print('データをFirestoreに追加しました');

      return docRef.id;
    } catch (e) {
      print('エラーが発生しました: $e');
      rethrow; // 例外を再スロー
    }
  }

  // Firestoreのデータを更新するメソッド
  Future<void> update_firebese_Stock(
      String? documentId, String text, DateTime updatedAt) async {
    try {
      await _firestore
          .collection('users')
          .doc("hogehoge")
          .collection('stocks')
          .doc(documentId)
          .update({
        'text': text,
        'updatedAt': updatedAt.toIso8601String(),
      });
      print('Firestoreでデータを更新しました: $documentId');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  void updateStock(int index, Stock updatedStock) {
    final updatedStocks = [...state.stocks];
    updatedStocks[index] = updatedStock;
    state = state.copyWith(stocks: updatedStocks);
  }

  Future<void> deleteStock(String documentId) async {
    try {
      await _firestore
          .collection('users')
          .doc("hogehoge")
          .collection('stocks')
          .doc(documentId)
          .delete();
      print('Firestoreからデータを削除しました: $documentId');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
