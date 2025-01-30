// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stocks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Stocks {
  List<Stock> get stocks => throw _privateConstructorUsedError;

  /// Create a copy of Stocks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StocksCopyWith<Stocks> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StocksCopyWith<$Res> {
  factory $StocksCopyWith(Stocks value, $Res Function(Stocks) then) =
      _$StocksCopyWithImpl<$Res, Stocks>;
  @useResult
  $Res call({List<Stock> stocks});
}

/// @nodoc
class _$StocksCopyWithImpl<$Res, $Val extends Stocks>
    implements $StocksCopyWith<$Res> {
  _$StocksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Stocks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
  }) {
    return _then(_value.copyWith(
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StocksImplCopyWith<$Res> implements $StocksCopyWith<$Res> {
  factory _$$StocksImplCopyWith(
          _$StocksImpl value, $Res Function(_$StocksImpl) then) =
      __$$StocksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Stock> stocks});
}

/// @nodoc
class __$$StocksImplCopyWithImpl<$Res>
    extends _$StocksCopyWithImpl<$Res, _$StocksImpl>
    implements _$$StocksImplCopyWith<$Res> {
  __$$StocksImplCopyWithImpl(
      _$StocksImpl _value, $Res Function(_$StocksImpl) _then)
      : super(_value, _then);

  /// Create a copy of Stocks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
  }) {
    return _then(_$StocksImpl(
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
    ));
  }
}

/// @nodoc

class _$StocksImpl implements _Stocks {
  _$StocksImpl({final List<Stock> stocks = const []}) : _stocks = stocks;

  final List<Stock> _stocks;
  @override
  @JsonKey()
  List<Stock> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  @override
  String toString() {
    return 'Stocks(stocks: $stocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StocksImpl &&
            const DeepCollectionEquality().equals(other._stocks, _stocks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stocks));

  /// Create a copy of Stocks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StocksImplCopyWith<_$StocksImpl> get copyWith =>
      __$$StocksImplCopyWithImpl<_$StocksImpl>(this, _$identity);
}

abstract class _Stocks implements Stocks {
  factory _Stocks({final List<Stock> stocks}) = _$StocksImpl;

  @override
  List<Stock> get stocks;

  /// Create a copy of Stocks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StocksImplCopyWith<_$StocksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
