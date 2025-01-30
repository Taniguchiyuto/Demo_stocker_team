import 'package:freezed_annotation/freezed_annotation.dart';

part 'Postscreen_model.freezed.dart';

@freezed
class PostScreenState with _$PostScreenState {
  const factory PostScreenState({
    @Default('') String text,
    @Default(true) bool isTextEmpty,
    @Default(false) bool isInitialTextApplied,
    @Default(false) bool isPostScreenTextInitialized,
    @Default(false) bool forceResetDone,
  }) = _PostScreenState;
}
