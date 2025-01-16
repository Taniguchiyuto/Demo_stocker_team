import 'package:cloud_firestore/cloud_firestore.dart';
import 'modal.dart';

class Stock {
  String text;
  DateTime createdAt;
  String? id; //FirestoreのドキュメントID(空でも良いよ(^^)/)
  Stock({
    this.id,
    required this.text,
    required this.createdAt,
  });
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestoreからデータを取得するメソッド
  Future<List<Stock>> fetchStocks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('stocks')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Stock(
          id: doc.id,
          text: data['text'] as String,
          createdAt: DateTime.parse(data['createdAt'] as String),
        );
      }).toList();
    } catch (e) {
      print('エラーが発生しました: $e');
      return [];
    }
  }

  // Firestoreにデータを追加するメソッド
  Future<void> addStock(String userId, String text, DateTime createdAt) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('stocks')
          .add({
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      });
      print('データをFirestoreに追加しました');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }

  // Firestoreのデータを更新するメソッド
  Future<void> updateStock(
      String userId, String documentId, String text, DateTime createdAt) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
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
  Future<void> deleteStock(String userId, String documentId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('stocks')
          .doc(documentId)
          .delete();
      print('Firestoreからデータを削除しました: $documentId');
    } catch (e) {
      print('エラーが発生しました: $e');
    }
  }
}
