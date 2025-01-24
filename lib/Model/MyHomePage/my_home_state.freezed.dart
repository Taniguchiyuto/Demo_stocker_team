// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyHomeState {
  List<Stock> get savedItems => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Create a copy of MyHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyHomeStateCopyWith<MyHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyHomeStateCopyWith<$Res> {
  factory $MyHomeStateCopyWith(
          MyHomeState value, $Res Function(MyHomeState) then) =
      _$MyHomeStateCopyWithImpl<$Res, MyHomeState>;
  @useResult
  $Res call({List<Stock> savedItems, String userId});
}

/// @nodoc
class _$MyHomeStateCopyWithImpl<$Res, $Val extends MyHomeState>
    implements $MyHomeStateCopyWith<$Res> {
  _$MyHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedItems = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      savedItems: null == savedItems
          ? _value.savedItems
          : savedItems // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyHomeStateImplCopyWith<$Res>
    implements $MyHomeStateCopyWith<$Res> {
  factory _$$MyHomeStateImplCopyWith(
          _$MyHomeStateImpl value, $Res Function(_$MyHomeStateImpl) then) =
      __$$MyHomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Stock> savedItems, String userId});
}

/// @nodoc
class __$$MyHomeStateImplCopyWithImpl<$Res>
    extends _$MyHomeStateCopyWithImpl<$Res, _$MyHomeStateImpl>
    implements _$$MyHomeStateImplCopyWith<$Res> {
  __$$MyHomeStateImplCopyWithImpl(
      _$MyHomeStateImpl _value, $Res Function(_$MyHomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedItems = null,
    Object? userId = null,
  }) {
    return _then(_$MyHomeStateImpl(
      savedItems: null == savedItems
          ? _value._savedItems
          : savedItems // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyHomeStateImpl implements _MyHomeState {
  const _$MyHomeStateImpl(
      {final List<Stock> savedItems = const [], this.userId = ''})
      : _savedItems = savedItems;

  final List<Stock> _savedItems;
  @override
  @JsonKey()
  List<Stock> get savedItems {
    if (_savedItems is EqualUnmodifiableListView) return _savedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedItems);
  }

  @override
  @JsonKey()
  final String userId;

  @override
  String toString() {
    return 'MyHomeState(savedItems: $savedItems, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyHomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._savedItems, _savedItems) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_savedItems), userId);

  /// Create a copy of MyHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyHomeStateImplCopyWith<_$MyHomeStateImpl> get copyWith =>
      __$$MyHomeStateImplCopyWithImpl<_$MyHomeStateImpl>(this, _$identity);
}

abstract class _MyHomeState implements MyHomeState {
  const factory _MyHomeState(
      {final List<Stock> savedItems, final String userId}) = _$MyHomeStateImpl;

  @override
  List<Stock> get savedItems;
  @override
  String get userId;

  /// Create a copy of MyHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyHomeStateImplCopyWith<_$MyHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
