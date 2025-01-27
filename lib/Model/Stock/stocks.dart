import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_app/Model/Stock/stock.dart';
part 'stocks.freezed.dart';

@freezed
class Stocks with _$Stocks {
  const factory Stocks({@Default([]) List<Stock> stocks}) = _Stocks;
}
