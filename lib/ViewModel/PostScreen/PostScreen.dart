import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostScreenState {
  final String text;
  final bool isTextEmpty;

  PostScreenState({this.text = '', this.isTextEmpty = true});

  PostScreenState copyWith({String? text, bool? isTextEmpty}) {
    return PostScreenState(
      text: text ?? this.text,
      isTextEmpty: isTextEmpty ?? this.isTextEmpty,
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
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

final postScreenProvider =
    StateNotifierProvider<PostScreenViewModel, PostScreenState>(
  (ref) => PostScreenViewModel(),
);
