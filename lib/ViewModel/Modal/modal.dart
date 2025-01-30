import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './modal_state.dart';

//ダイアログの状態を表すクラス
class ModalViewModel extends StateNotifier<ModalState> {
  ModalViewModel() : super(const ModalState());

  // ダイアログの状態を設定する
  void configureDialog({
    required String title,
    required String description,
    required String primaryButtonText,
    required VoidCallback primaryButtonAction,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonAction,
    bool isReversed = false,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      primaryButtonText: primaryButtonText,
      primaryButtonAction: primaryButtonAction,
      secondaryButtonText: secondaryButtonText,
      secondaryButtonAction: secondaryButtonAction,
      isReversed: isReversed,
    );
  }

  // ダイアログの状態をリセットする
  void reset() {
    state = const ModalState();
  }
}

// RiverpodのProvider
final modalProvider = StateNotifierProvider<ModalViewModel, ModalState>((ref) {
  return ModalViewModel();
});
