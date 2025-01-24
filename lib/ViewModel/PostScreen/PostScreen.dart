import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/PostScreen/Postscreen_model.dart';

final postScreenProvider =
    StateNotifierProvider<PostScreenViewModel, PostScreenState>(
  (ref) => PostScreenViewModel(),
);

class PostScreenViewModel extends StateNotifier<PostScreenState> {
  final TextEditingController textController = TextEditingController();

  PostScreenViewModel() : super(const PostScreenState()) {
    textController.addListener(() {
      state = state.copyWith(
        text: textController.text,
        isTextEmpty: textController.text.isEmpty,
      );
      print('text!: ${state.text}');
    });
  }

  void updateState(PostScreenState newState) {
    state = newState; // 新しい状態を適用
  }

  // forceResetDoneをfalseにリセット
  void resetForceResetDone() {
    state = state.copyWith(forceResetDone: false, isInitialTextApplied: false);
  }

  // 状態をリセットするメソッド
  void resetState() {
    print('textController.text_1: ${textController.text}');
    state = const PostScreenState(); // 状態を初期化
    print('textController.text_2: ${textController.text}');
    state = state.copyWith(forceResetDone: true); // フラグを立てる
    textController.clear();
    print('textController.text_3: ${textController.text}');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
