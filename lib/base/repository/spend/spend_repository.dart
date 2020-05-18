import 'package:flutter/foundation.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/customer/request_model/real_estate_payment_request_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/customer/response_model/real_estate_properties_response_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/customer/response_model/spend_rules_response_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/spend/spend_api.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/voucher/response_model/voucher_purchase_response_model.dart';

class SpendRepository {
  SpendRepository(this._spendApi);

  final SpendApi _spendApi;

  Future<SpendRuleListResponseModel> getSpendRules({
    int currentPage = 1,
    int pageSize = 3,
  }) =>
      _spendApi.getSpendRules(
        currentPage: currentPage,
        pageSize: pageSize,
      );

  Future<SpendRule> getSpendRuleDetail({@required String spendRuleId}) =>
      _spendApi.getSpendRuleById(spendRuleId: spendRuleId);

  Future<VoucherPurchaseResponseModel> purchaseVoucher({
    @required String spendRuleId,
  }) =>
      _spendApi.purchaseVoucher(spendRuleId: spendRuleId);

  Future<RealEstatePropertyListResponseModel> getProperties({
    @required String spendRuleId,
  }) =>
      _spendApi.getProperties(spendRuleId: spendRuleId);

  Future<void> submitPropertyPayment({
    @required String id,
    @required String instalmentName,
    @required String fiatCurrencyCode,
    @required String spendRuleId,
    String amountInTokens,
    double amountInFiat,
  }) =>
      _spendApi.postRealEstatePayment(RealEstatePaymentRequestModel(
        id,
        instalmentName,
        amountInTokens,
        amountInFiat,
        fiatCurrencyCode,
        spendRuleId,
      ));
}
