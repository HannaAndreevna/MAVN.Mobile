import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/request_model/voucher_purchase_request_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/voucher_purchase_response_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/http_client.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/base_api.dart';

class CampaignApi extends BaseApi {
  CampaignApi(HttpClient httpClient) : super(httpClient);

  static const String vouchersBasePath = '/smartVouchers';
  static const String vouchersPath = '$vouchersBasePath/campaigns';
  static const String voucherDetailsPath = '$vouchersPath/search';
  static const String purchaseVoucherPath = '$vouchersBasePath/reserve';

  //query params
  static const String queryParamCurrentPage = 'CurrentPage';
  static const String queryParamPageSize = 'PageSize';
  static const String queryParamId = 'id';

  Future<CampaignListResponseModel> getVouchers(
    int pageSize,
    int currentPage,
  ) =>
      exceptionHandledHttpClientRequest(() async {
        final response = await httpClient
            .get<Map<String, dynamic>>(vouchersPath, queryParameters: {
          queryParamCurrentPage: currentPage,
          queryParamPageSize: pageSize,
        });
        return CampaignListResponseModel.fromJson(response.data);
      });

  Future<CampaignResponseModel> getVoucherDetailsById(String id) async =>
      exceptionHandledHttpClientRequest(() async {
        final response = await httpClient
            .get<Map<String, dynamic>>(voucherDetailsPath, queryParameters: {
          queryParamId: id,
        });
        return CampaignResponseModel.fromJson(response.data);
      });

  Future<VoucherPurchaseResponseModel> purchaseVoucher(
    VoucherPurchaseRequestModel model,
  ) =>
      exceptionHandledHttpClientRequest(() async {
        final response = await httpClient.post<Map<String, dynamic>>(
          purchaseVoucherPath,
          data: model.toJson(),
        );
        return VoucherPurchaseResponseModel.fromJson(response.data);
      });
}
