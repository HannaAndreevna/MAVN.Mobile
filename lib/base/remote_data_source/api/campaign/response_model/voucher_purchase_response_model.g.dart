// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_purchase_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherPurchaseResponseModel _$VoucherPurchaseResponseModelFromJson(
    Map<String, dynamic> json) {
  return VoucherPurchaseResponseModel(
    paymentUrl: json['PaymentUrl'] as String,
    errorCode: _$enumDecodeNullable(
        _$VoucherPurchaseErrorCodeEnumMap, json['ErrorCode']),
    reservedVoucherShortCode: json['AlreadyReservedVoucherShortCode'] as String,
  );
}

Map<String, dynamic> _$VoucherPurchaseResponseModelToJson(
        VoucherPurchaseResponseModel instance) =>
    <String, dynamic>{
      'PaymentUrl': instance.paymentUrl,
      'ErrorCode': _$VoucherPurchaseErrorCodeEnumMap[instance.errorCode],
      'AlreadyReservedVoucherShortCode': instance.reservedVoucherShortCode,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VoucherPurchaseErrorCodeEnumMap = {
  VoucherPurchaseErrorCode.none: 'None',
  VoucherPurchaseErrorCode.customerHaveAnotherReservedVoucher:
      'CustomerHaveAnotherReservedVoucher ',
};
