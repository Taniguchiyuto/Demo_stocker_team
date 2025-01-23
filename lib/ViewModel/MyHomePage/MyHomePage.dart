import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/firestore/firestore_model.dart';
import '../../Model/Stock/stock.dart';

final myHomeProvider = StateNotifierProvider<MyHomeViewModel, MyHomeState>(
  (ref) => MyHomeViewModel(),
);

//StateNotifierが扱う状態。
//ここに必要な状態(ユーザID,Stockリストなど)をまとめて持たせてもOK。
class MyHomeState {
  final List<Stock> savedItems;

  final String userId;
  //コンストラクタ
  MyHomeState({
    required this.savedItems,
    required this.userId,
  });

  //copyWithは状態を部分的に更新するのに使う。
  MyHomeState copyWith({
    List<Stock>? savedItems,
    bool? isLoading,
    String? userId,
  }) {
    return MyHomeState(
      savedItems: savedItems ?? this.savedItems,
      // isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
    );
  }
}

//StateNotifierを継承して状態管理を行う
class MyHomeViewModel extends StateNotifier<MyHomeState> {
  final FirestoreService _firestoreService = FirestoreService();
  MyHomeViewModel()
      : super(
          //デフォルトのstateを指定
          MyHomeState(
            savedItems: [],

            userId: 'hogehoge', //ここで固定にしている(必要に応じて外部から注入可)
          ),
        ) {
    // StateNotifierのコンストラクタで初期化処理を行う(必要に応じて)
    fetchStocksFromfirestore();
  }
  //Firestoreから取得
  Future<void> fetchStocksFromfirestore() async {
    try {
      final fetchedStocks = await _firestoreService.fetchStocks(state.userId);
      state = state.copyWith(savedItems: fetchedStocks);
      print('Firestoreからデータを取得しました');
    } catch (e) {
      print('エラーが発生しました');
    }
  }

  //Firestoreに新規追加
  Future<void> addStockToFirestore(String text, DateTime createdAt) async {
    try {
      final String documentId =
          await _firestoreService.addStock(state.userId, text, createdAt);

      //新しい要素を追加したリストを作ってstateを更新
      final newList = [
        ...state.savedItems,
        Stock(
          id: documentId,
          text: text,
          createdAt: createdAt,
        )
      ];
      state = state.copyWith(savedItems: newList);
    } catch (e) {
      print('エラーが発生しました');
    }
  }

  //Firestoreの既存ドキュメントを更新
  // Firestoreの既存ドキュメントを更新
  Future<void> updateStock(
    int index,
    String text,
    DateTime createdAt,
  ) async {
    final stock = state.savedItems[index];
    final documentId = stock.id;
    if (documentId == null) {
      print("エラー: ドキュメントIDがnullのため更新できません");
      return;
    }
    try {
      await _firestoreService.updateStock(
          state.userId, documentId, text, createdAt);
      // リストをコピーして該当箇所だけ置き換え
      final newStock = Stock(
        id: documentId,
        text: text,
        createdAt: createdAt,
      );
      final newList = [...state.savedItems];
      newList[index] = newStock;
      state = state.copyWith(savedItems: newList);
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  //Firestoreのドキュメント削除
  Future<void> deleteStock(int index) async {
    final stock = state.savedItems[index];
    final documentId = stock.id;
    if (documentId == null) {
      print('エラー:ドキュメントIDがnullのため削除できません');
      return;
    }
    try {
      await _firestoreService.deleteStock(state.userId, documentId);
      final newList = [...state.savedItems];
      newList.removeAt(index);
      state = state.copyWith(savedItems: newList);
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
