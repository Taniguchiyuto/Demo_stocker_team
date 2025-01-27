import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../firestore/firestore_model.dart';
import 'stock.dart';
import 'stocks.dart';

final StocksModelProvider =
    StateNotifierProvider<StocksModel, Stocks>((ref) => StocksModel(ref));

class StocksModel extends StateNotifier<Stocks> {
  final FirestoreService _firestoreService = FirestoreService();

  final Ref ref;

  StocksModel(this.ref) : super(const Stocks()) {
    () async {
      await streamStocks();
    }();
  }
  // final stocksModelProvider =
  //   StateNotifierProvider<StocksModel, Stocks>((ref) => StocksModel(ref));

  Future<void> streamStocks() async {
    try {
      final streamStocks = await ref.read(StocksReposi).streamStocks();
      streamStocks.listen((stocks) {
        state = state.copyWith(stocks: stocks);
      });
    } on Exception catch (e) {
      print('streamStocks error: $e');
    }

    // // Firestoreから
    // Future<void> listenToStocks() async {
    //   try {
    //     final stockStream = await _firestoreService.streamStocks();
    //     stockStream.listen((stocks) {
    //       Stock.savedItems = stocks;
    //       state = MyHomeState();
    //       // state = state.copyWith(stocks: stockStream);
    //     });
    //     print('Firestoreからデータを取得しました');
    //   } catch (e) {
    //     print('エラーが発生しました: $e');
    //   }
    // }

    // Future<void> listenToStocks() async {
    //   await _firestoreService.listenToStocks();
    // }

    // Firestoreの既存ドキュメントを更新
    Future<void> updateStock(int index, String text, DateTime createdAt) async {
      final stock = Stock.savedItems[index];
      final documentId = stock.id;
      if (documentId == null) {
        print("エラー: ドキュメントIDがnullのため更新できません");
        return;
      }
      try {
        await _firestoreService.updateStock(documentId, text, createdAt);
        final newStock =
            Stock(id: documentId, text: text, createdAt: createdAt);
        final newList = [...Stock.savedItems];
        newList[index] = newStock;
        Stock.savedItems = newList;
        state = state.copyWith(stocks: newList);
      } catch (e) {
        print('エラーが発生しました: $e');
      }
    }

    // Firestoreのドキュメント削除
    Future<void> deleteStock(int index) async {
      final stock = Stock.savedItems[index];
      final documentId = stock.id;
      if (documentId == null) {
        print('エラー: ドキュメントIDがnullのため削除できません');
        return;
      }
      try {
        await _firestoreService.deleteStock(documentId);
        final newList = [...Stock.savedItems]..removeAt(index);
        Stock.savedItems = newList;
      } catch (e) {
        print('エラーが発生しました: $e');
      }
    }
  }
}
