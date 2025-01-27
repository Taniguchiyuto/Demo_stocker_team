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

  PostScreenViewModel() : super(const PostScreenState()) {
    // textController.addListener(() {
    //   state = state.copyWith(
    //     text: textController.text,
    //     isTextEmpty: textController.text.isEmpty,
    //   );
    //   print('text!: ${state.text}');
    // });
  }

  void updateText(String text) {
    state = state.copyWith(
      text: text,
      isTextEmpty: text.isEmpty,
    );
  }

  // void updateState(PostScreenState newState) {
  //   state = newState; // 新しい状態を適用
  // }

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
    state = const PostScreenState(); // 状態を初期化

    state = state.copyWith(forceResetDone: true); // フラグを立てる
  }

  @override
  void dispose() {
    // textController.dispose();
    super.dispose();
  }
}
