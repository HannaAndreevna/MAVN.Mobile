import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/lazy_localized_strings.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/generic_list_bloc.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';
import 'package:lykke_mobile_mavn/base/repository/campaign/campaign_repository.dart';
import 'package:lykke_mobile_mavn/feature_home/di/home_page_module.dart';
import 'package:lykke_mobile_mavn/library_dependency_injection/core.dart';
import 'package:lykke_mobile_mavn/library_models/fiat_currency.dart';

class PopularOffersBloc
    extends GenericListBloc<CampaignListResponseModel, CampaignResponseModel> {
  PopularOffersBloc(this._campaignRepository)
      : super(genericErrorSubtitle: LazyLocalizedStrings.defaultGenericError);

  final CampaignRepository _campaignRepository;

  @override
  List<CampaignResponseModel> getDataFromResponse(
          CampaignListResponseModel response) =>
      response.campaigns;

  @override
  int getTotalCount(CampaignListResponseModel response) => response.totalCount;

  @override
  Future<CampaignListResponseModel> loadData(int page) async {
    List<CampaignResponseModel> compaigns = [];
    CampaignResponseModel compaign = CampaignResponseModel(
        id: 151.toString(),
        partnerId: "d9643c46-80f3-4b72-a9cc-b5c2247ce454",
        partnerName: "P Test",
        imageUrl:
            "https://openmavnsmartvouchers.blob.core.windows.net/campaignfiles/9f15d86f-f136-4148-a8f8-f29098c7652e.jpeg",
        price: FiatCurrency(assetSymbol: 'CHF', value: 20));
    compaigns.add(compaign);
    return await CampaignListResponseModel(
        campaigns: compaigns, totalCount: compaigns.length);
  }
}

PopularOffersBloc useCampaignListBloc() =>
    ModuleProvider.of<HomePageModule>(useContext()).popularOffersBloc;
