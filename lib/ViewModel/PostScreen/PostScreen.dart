import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './Postscreen_model.dart';

final postScreenProvider =
    StateNotifierProvider<PostScreenViewModel, PostScreenState>(
  (ref) => PostScreenViewModel(),
);

class PostScreenViewModel extends StateNotifier<PostScreenState> {
  final TextEditingController textController = TextEditingController();
  // PostScreenViewModel() : super(const PostScreenState());

  PostScreenViewModel() : super(const PostScreenState()) {}

  void updateText(String text) {
    state = state.copyWith(
      text: text,
      isTextEmpty: text.isEmpty,
    );
  }

//isInitialTextAppliedを更新
  void updateIsInitialTextApplied(bool value) {
    state = state.copyWith(isInitialTextApplied: value);
  }

  // forceResetDoneをfalseにリセット
  void resetForceResetDone() {
    state = state.copyWith(forceResetDone: false, isInitialTextApplied: false);
  }

  // 状態をリセットするメソッド
  void resetState() {
    textController.clear(); // **TextFieldの値をクリア**
    state = const PostScreenState(); // 状態を初期化

    state = state.copyWith(forceResetDone: true); // フラグを立てる
  }

  @override
  void dispose() {
    // textController.dispose();
    super.dispose();
  }
}
