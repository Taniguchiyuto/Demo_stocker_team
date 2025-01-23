import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postScreenProvider =
    StateNotifierProvider<PostScreenViewModel, PostScreenState>(
  (ref) => PostScreenViewModel(),
);

class PostScreenState {
  final String text;
  final bool isTextEmpty;
  final bool isInitialTextApplied;
  final bool isPostScreenTextInitialized; // ユニークなフラグ名

  PostScreenState({
    this.text = '',
    this.isTextEmpty = true,
    this.isInitialTextApplied = false,
    this.isPostScreenTextInitialized = false, // デフォルトは未適用
  });

  PostScreenState copyWith({
    String? text,
    bool? isTextEmpty,
    bool? isInitialTextApplied,
  }) {
    return PostScreenState(
      text: text ?? this.text,
      isTextEmpty: isTextEmpty ?? this.isTextEmpty,
      isInitialTextApplied: isInitialTextApplied ?? this.isInitialTextApplied,
    );
  }
}

class PostScreenViewModel extends StateNotifier<PostScreenState> {
  final TextEditingController textController = TextEditingController();

  PostScreenViewModel() : super(PostScreenState()) {
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

  //状態をリセットするメソッド
  void resetState() {
    state = PostScreenState(); // フラグも初期化
    print('textController.text_1: ${textController.text}');
    state = PostScreenState(); //状態を初期化
    print('textController.text_2: ${textController.text}');
    textController.clear();
    print('textController.text_3: ${textController.text}');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
