import 'package:freezed_annotation/freezed_annotation.dart';
import '../../Model/Stock/stock.dart';

part 'my_home_state.freezed.dart';

@freezed
class MyHomeState with _$MyHomeState {
  const factory MyHomeState({
    @Default([]) List<Stock> savedItems,
    @Default('') String userId,
  }) = _MyHomeState;
}
