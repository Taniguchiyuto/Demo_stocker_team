// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Postscreen_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostScreenState {
  String get text => throw _privateConstructorUsedError;
  bool get isTextEmpty => throw _privateConstructorUsedError;
  bool get isInitialTextApplied => throw _privateConstructorUsedError;
  bool get isPostScreenTextInitialized => throw _privateConstructorUsedError;
  bool get forceResetDone => throw _privateConstructorUsedError;

  /// Create a copy of PostScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostScreenStateCopyWith<PostScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostScreenStateCopyWith<$Res> {
  factory $PostScreenStateCopyWith(
          PostScreenState value, $Res Function(PostScreenState) then) =
      _$PostScreenStateCopyWithImpl<$Res, PostScreenState>;
  @useResult
  $Res call(
      {String text,
      bool isTextEmpty,
      bool isInitialTextApplied,
      bool isPostScreenTextInitialized,
      bool forceResetDone});
}

/// @nodoc
class _$PostScreenStateCopyWithImpl<$Res, $Val extends PostScreenState>
    implements $PostScreenStateCopyWith<$Res> {
  _$PostScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isTextEmpty = null,
    Object? isInitialTextApplied = null,
    Object? isPostScreenTextInitialized = null,
    Object? forceResetDone = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isTextEmpty: null == isTextEmpty
          ? _value.isTextEmpty
          : isTextEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialTextApplied: null == isInitialTextApplied
          ? _value.isInitialTextApplied
          : isInitialTextApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      isPostScreenTextInitialized: null == isPostScreenTextInitialized
          ? _value.isPostScreenTextInitialized
          : isPostScreenTextInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      forceResetDone: null == forceResetDone
          ? _value.forceResetDone
          : forceResetDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostScreenStateImplCopyWith<$Res>
    implements $PostScreenStateCopyWith<$Res> {
  factory _$$PostScreenStateImplCopyWith(_$PostScreenStateImpl value,
          $Res Function(_$PostScreenStateImpl) then) =
      __$$PostScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text,
      bool isTextEmpty,
      bool isInitialTextApplied,
      bool isPostScreenTextInitialized,
      bool forceResetDone});
}

/// @nodoc
class __$$PostScreenStateImplCopyWithImpl<$Res>
    extends _$PostScreenStateCopyWithImpl<$Res, _$PostScreenStateImpl>
    implements _$$PostScreenStateImplCopyWith<$Res> {
  __$$PostScreenStateImplCopyWithImpl(
      _$PostScreenStateImpl _value, $Res Function(_$PostScreenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isTextEmpty = null,
    Object? isInitialTextApplied = null,
    Object? isPostScreenTextInitialized = null,
    Object? forceResetDone = null,
  }) {
    return _then(_$PostScreenStateImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isTextEmpty: null == isTextEmpty
          ? _value.isTextEmpty
          : isTextEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialTextApplied: null == isInitialTextApplied
          ? _value.isInitialTextApplied
          : isInitialTextApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      isPostScreenTextInitialized: null == isPostScreenTextInitialized
          ? _value.isPostScreenTextInitialized
          : isPostScreenTextInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      forceResetDone: null == forceResetDone
          ? _value.forceResetDone
          : forceResetDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PostScreenStateImpl implements _PostScreenState {
  const _$PostScreenStateImpl(
      {this.text = '',
      this.isTextEmpty = true,
      this.isInitialTextApplied = false,
      this.isPostScreenTextInitialized = false,
      this.forceResetDone = false});

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final bool isTextEmpty;
  @override
  @JsonKey()
  final bool isInitialTextApplied;
  @override
  @JsonKey()
  final bool isPostScreenTextInitialized;
  @override
  @JsonKey()
  final bool forceResetDone;

  @override
  String toString() {
    return 'PostScreenState(text: $text, isTextEmpty: $isTextEmpty, isInitialTextApplied: $isInitialTextApplied, isPostScreenTextInitialized: $isPostScreenTextInitialized, forceResetDone: $forceResetDone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostScreenStateImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isTextEmpty, isTextEmpty) ||
                other.isTextEmpty == isTextEmpty) &&
            (identical(other.isInitialTextApplied, isInitialTextApplied) ||
                other.isInitialTextApplied == isInitialTextApplied) &&
            (identical(other.isPostScreenTextInitialized,
                    isPostScreenTextInitialized) ||
                other.isPostScreenTextInitialized ==
                    isPostScreenTextInitialized) &&
            (identical(other.forceResetDone, forceResetDone) ||
                other.forceResetDone == forceResetDone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, isTextEmpty,
      isInitialTextApplied, isPostScreenTextInitialized, forceResetDone);

  /// Create a copy of PostScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostScreenStateImplCopyWith<_$PostScreenStateImpl> get copyWith =>
      __$$PostScreenStateImplCopyWithImpl<_$PostScreenStateImpl>(
          this, _$identity);
}

abstract class _PostScreenState implements PostScreenState {
  const factory _PostScreenState(
      {final String text,
      final bool isTextEmpty,
      final bool isInitialTextApplied,
      final bool isPostScreenTextInitialized,
      final bool forceResetDone}) = _$PostScreenStateImpl;

  @override
  String get text;
  @override
  bool get isTextEmpty;
  @override
  bool get isInitialTextApplied;
  @override
  bool get isPostScreenTextInitialized;
  @override
  bool get forceResetDone;

  /// Create a copy of PostScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostScreenStateImplCopyWith<_$PostScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
