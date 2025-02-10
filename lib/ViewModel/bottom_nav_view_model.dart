import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavViewModel extends StateNotifier<int> {
  BottomNavViewModel() : super(0);
  //選択インデックスを更新するメソッド
  void setIndex(int index) {
    state = index;
  }
}

//Riverpodのプロバイダーを定義
final bottomNavProvider = StateNotifierProvider<BottomNavViewModel, int>((ref) {
  return BottomNavViewModel();
});
