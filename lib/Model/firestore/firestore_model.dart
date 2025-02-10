import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Stock/stock.dart';
import '../Stock/stocks.dart';
import '../Stock/stocks_model.dart';

class FirestoreService extends StateNotifier<Stocks> {
  FirestoreService() : super(Stocks()) {}
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestoreからデータを取得するメソッド
  //スナップショットをストリームで取得し、Stockリストに変換
  Future<Stream<List<Stock>>> streamStocks() async {
    try {
      final collectionRef = _firestore
          .collection('users')
          .doc("hogehoge")
          .collection('stocks')
          .orderBy('createdAt', descending: false);

      // スナップショットをストリームで取得し、Stockリストに変換
      final stream = collectionRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Stock(
            id: doc.id,
            text: data['text'] as String,
            createdAt: DateTime.parse(data['createdAt'] as String),
            updatedAt: data['updatedAt'] == null
                ? null
                : DateTime.parse(data['updatedAt'] as String),
          );
        }).toList();
      });

      return Future.value(stream);
    } catch (e) {
      print('エラーが発生しました: $e');
      // エラー時には空のストリームを返す
      return Future.value(Stream.value([]));
    }
  }

  //スナップショットでstockScoreを更新
  // Stream<int> streamstockScore() {
  //   try {
  //     final collectionRef = _firestore
  //         .collection('users')
  //         .doc("hogehoge")
  //         .collection('stockScore');
  //     //常にcollectionの最新のドキュメントの値を取得;
  //     return collectionRef.snapshots().map((snapshot) {
  //       return snapshot.docs.map((doc) {
  //         final data = doc.data();
  //         return data['stockScore'] as int;
  //       }).first;
  //     });
  //   } catch (e) {
  //     print('エラーが発生しました: $e');
  //     return Stream.value(0);
  //   }
  // }
  Stream<int> streamstockScore() {
    try {
      final docRef = _firestore.collection('users').doc("hogehoge");
      // ドキュメントのスナップショットを取得
      return docRef.snapshots().map((snapshot) {
        final data = snapshot.data();
        return data != null ? data['stockScore'] as int : 0;
      });
    } catch (e) {
      print('エラーが発生しました: $e');
      return Stream.value(0);
    }
  }
}

//FirestoreServiceのプロバイダを定義
final StocksReposi = Provider((ref) => FirestoreService());
