import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/lazy_localized_strings.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/generic_list_bloc.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';
import 'package:lykke_mobile_mavn/base/repository/campaign/campaign_repository.dart';
import 'package:lykke_mobile_mavn/feature_home/di/home_page_module.dart';
import 'package:lykke_mobile_mavn/library_dependency_injection/core.dart';

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
  Future<CampaignListResponseModel> loadData(int page) =>
      _campaignRepository.getPopularCampaigns();
}

PopularOffersBloc usePopularOffersListBloc() =>
    ModuleProvider.of<HomePageModule>(useContext()).popularOffersBloc;
