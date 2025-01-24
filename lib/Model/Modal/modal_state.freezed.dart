// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModalState {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get primaryButtonText => throw _privateConstructorUsedError;
  VoidCallback? get primaryButtonAction => throw _privateConstructorUsedError;
  String? get secondaryButtonText => throw _privateConstructorUsedError;
  VoidCallback? get secondaryButtonAction => throw _privateConstructorUsedError;
  bool get isReversed => throw _privateConstructorUsedError;

  /// Create a copy of ModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModalStateCopyWith<ModalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModalStateCopyWith<$Res> {
  factory $ModalStateCopyWith(
          ModalState value, $Res Function(ModalState) then) =
      _$ModalStateCopyWithImpl<$Res, ModalState>;
  @useResult
  $Res call(
      {String title,
      String description,
      String primaryButtonText,
      VoidCallback? primaryButtonAction,
      String? secondaryButtonText,
      VoidCallback? secondaryButtonAction,
      bool isReversed});
}

/// @nodoc
class _$ModalStateCopyWithImpl<$Res, $Val extends ModalState>
    implements $ModalStateCopyWith<$Res> {
  _$ModalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? primaryButtonText = null,
    Object? primaryButtonAction = freezed,
    Object? secondaryButtonText = freezed,
    Object? secondaryButtonAction = freezed,
    Object? isReversed = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      primaryButtonText: null == primaryButtonText
          ? _value.primaryButtonText
          : primaryButtonText // ignore: cast_nullable_to_non_nullable
              as String,
      primaryButtonAction: freezed == primaryButtonAction
          ? _value.primaryButtonAction
          : primaryButtonAction // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      secondaryButtonText: freezed == secondaryButtonText
          ? _value.secondaryButtonText
          : secondaryButtonText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryButtonAction: freezed == secondaryButtonAction
          ? _value.secondaryButtonAction
          : secondaryButtonAction // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      isReversed: null == isReversed
          ? _value.isReversed
          : isReversed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModalStateImplCopyWith<$Res>
    implements $ModalStateCopyWith<$Res> {
  factory _$$ModalStateImplCopyWith(
          _$ModalStateImpl value, $Res Function(_$ModalStateImpl) then) =
      __$$ModalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String primaryButtonText,
      VoidCallback? primaryButtonAction,
      String? secondaryButtonText,
      VoidCallback? secondaryButtonAction,
      bool isReversed});
}

/// @nodoc
class __$$ModalStateImplCopyWithImpl<$Res>
    extends _$ModalStateCopyWithImpl<$Res, _$ModalStateImpl>
    implements _$$ModalStateImplCopyWith<$Res> {
  __$$ModalStateImplCopyWithImpl(
      _$ModalStateImpl _value, $Res Function(_$ModalStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? primaryButtonText = null,
    Object? primaryButtonAction = freezed,
    Object? secondaryButtonText = freezed,
    Object? secondaryButtonAction = freezed,
    Object? isReversed = null,
  }) {
    return _then(_$ModalStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      primaryButtonText: null == primaryButtonText
          ? _value.primaryButtonText
          : primaryButtonText // ignore: cast_nullable_to_non_nullable
              as String,
      primaryButtonAction: freezed == primaryButtonAction
          ? _value.primaryButtonAction
          : primaryButtonAction // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      secondaryButtonText: freezed == secondaryButtonText
          ? _value.secondaryButtonText
          : secondaryButtonText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryButtonAction: freezed == secondaryButtonAction
          ? _value.secondaryButtonAction
          : secondaryButtonAction // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      isReversed: null == isReversed
          ? _value.isReversed
          : isReversed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ModalStateImpl with DiagnosticableTreeMixin implements _ModalState {
  const _$ModalStateImpl(
      {this.title = '',
      this.description = '',
      this.primaryButtonText = '',
      this.primaryButtonAction,
      this.secondaryButtonText,
      this.secondaryButtonAction,
      this.isReversed = false});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String primaryButtonText;
  @override
  final VoidCallback? primaryButtonAction;
  @override
  final String? secondaryButtonText;
  @override
  final VoidCallback? secondaryButtonAction;
  @override
  @JsonKey()
  final bool isReversed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ModalState(title: $title, description: $description, primaryButtonText: $primaryButtonText, primaryButtonAction: $primaryButtonAction, secondaryButtonText: $secondaryButtonText, secondaryButtonAction: $secondaryButtonAction, isReversed: $isReversed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ModalState'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('primaryButtonText', primaryButtonText))
      ..add(DiagnosticsProperty('primaryButtonAction', primaryButtonAction))
      ..add(DiagnosticsProperty('secondaryButtonText', secondaryButtonText))
      ..add(DiagnosticsProperty('secondaryButtonAction', secondaryButtonAction))
      ..add(DiagnosticsProperty('isReversed', isReversed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModalStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.primaryButtonText, primaryButtonText) ||
                other.primaryButtonText == primaryButtonText) &&
            (identical(other.primaryButtonAction, primaryButtonAction) ||
                other.primaryButtonAction == primaryButtonAction) &&
            (identical(other.secondaryButtonText, secondaryButtonText) ||
                other.secondaryButtonText == secondaryButtonText) &&
            (identical(other.secondaryButtonAction, secondaryButtonAction) ||
                other.secondaryButtonAction == secondaryButtonAction) &&
            (identical(other.isReversed, isReversed) ||
                other.isReversed == isReversed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      primaryButtonText,
      primaryButtonAction,
      secondaryButtonText,
      secondaryButtonAction,
      isReversed);

  /// Create a copy of ModalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModalStateImplCopyWith<_$ModalStateImpl> get copyWith =>
      __$$ModalStateImplCopyWithImpl<_$ModalStateImpl>(this, _$identity);
}

abstract class _ModalState implements ModalState {
  const factory _ModalState(
      {final String title,
      final String description,
      final String primaryButtonText,
      final VoidCallback? primaryButtonAction,
      final String? secondaryButtonText,
      final VoidCallback? secondaryButtonAction,
      final bool isReversed}) = _$ModalStateImpl;

  @override
  String get title;
  @override
  String get description;
  @override
  String get primaryButtonText;
  @override
  VoidCallback? get primaryButtonAction;
  @override
  String? get secondaryButtonText;
  @override
  VoidCallback? get secondaryButtonAction;
  @override
  bool get isReversed;

  /// Create a copy of ModalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModalStateImplCopyWith<_$ModalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
