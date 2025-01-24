import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'modal_state.freezed.dart';

@freezed
class ModalState with _$ModalState {
  const factory ModalState({
    @Default('') String title,
    @Default('') String description,
    @Default('') String primaryButtonText,
    VoidCallback? primaryButtonAction,
    String? secondaryButtonText,
    VoidCallback? secondaryButtonAction,
    @Default(false) bool isReversed,
  }) = _ModalState;
}
