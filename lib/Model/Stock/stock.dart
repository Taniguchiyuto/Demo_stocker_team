import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

@freezed
class Stock with _$Stock {
  const factory Stock({
    String? id, // FirestoreのドキュメントID（nullを許容）
    required String text, // 必須の文字列
    required DateTime createdAt, // 必須の日付
  }) = _Stock;

  // JSON シリアライズ用のメソッドを生成
  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}
