import 'package:cloud_firestore/cloud_firestore.dart';
import '../Stock/stock.dart';
import '../../ViewModel/MyHomePage/my_home_state.dart';

class FirestoreService {
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

  // Firestoreにデータを追加するメソッド
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
  Future<void> updateStock(
      String documentId, String text, DateTime createdAt) async {
    try {
      await _firestore
          .collection('users')
          .doc("hogehoge")
          .collection('stocks')
          .doc(documentId)
          .update({
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      });
      print('Firestoreでデータを更新しました: $documentId');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreのデータを削除するメソッド
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
